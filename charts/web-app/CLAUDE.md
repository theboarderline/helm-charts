# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Helm chart for deploying theboarderline platform web apps (React frontend + Go API) on GKE. Published to `https://theboarderline.github.io/helm-charts` via chart-releaser on merge to `main`.

## Dev Workflow

```bash
make test               # renders templates with test-values.yaml → test-output.yaml, then git diff to show changes
helm lint .             # lint check
helm template test . -f test-values.yaml -n test-ns   # render to stdout for inspection
```

`make test` is the primary validation loop — always run it after changes and review the diff in `test-output.yaml`.

## Versioning

Bump `version` in `Chart.yaml` for every change. Downstream apps pin to a chart version in their `cloudbuild.yaml`.

## Required Values

Every deployment must supply:
- `lifecycle` — e.g. `dev`, `stage`, `prod`, `lswingz-42`
- `app_code` — e.g. `luckyswingz`
- `domain` — e.g. `luckyswingz.com`
- `gke_project_id`, `db_project_id` — GCP project IDs for GKE cluster and Cloud SQL

## Architecture

The chart deploys two workloads into a namespace named `{lifecycle}-{app_code}` (the `app_label`):

- **nginx-dep** — React frontend served by nginx, runs as non-root with read-only root filesystem. Nginx proxies `/api/` (and `/admin/`, `/accounts/` for Django) to `api-svc` via the `api-config` ConfigMap.
- **api-dep** — Go (or Django) API backend. Runs as non-root with read-only root filesystem. Uses Workload Identity via the `{app_code}-sa` KSA.

### Key Derived Values (`_helpers.tpl`)

| Helper | Output |
|---|---|
| `app_label` | `{lifecycle}-{app_code}` — used as namespace, release name, resource prefix |
| `app_project` | `{app_code}-app-project` — GCP project for Secret Manager, Artifact Registry, Cloud Build |
| `subdomain` | prod → `domain`; non-prod → `{lifecycle}.{domain}` |
| `registry_name` | `{lifecycle}-{app_code}-v3-images` — Artifact Registry repo |
| `api_image` | `{region}-docker.pkg.dev/{app_project}/{registry_name}/api:{api.tag}` |
| `nginx_image` | `{region}-docker.pkg.dev/{app_project}/{registry_name}/react:{nginx.tag}` |
| `branch` | prod → `main`; non-prod → `{lifecycle}` |

### ConfigMaps

- **react-config** (`env.js`) — runtime JS config injected into nginx container at `/var/www/env`. Exposes `LIFECYCLE`, `API_URL`, bucket names, Stripe public key, Firebase domain.
- **api-config** (`api.conf`) — nginx location block that proxies to `api-svc`. Mounted at `/etc/nginx/conf.d`.

### Feature Flag Pattern

Nearly every resource is gated by `enabled` boolean flags. Most templates also guard with `and .Values.enabled` at the top level and many add `not .Values.local` to skip cloud resources in local dev. When adding a new integration, follow this pattern: add an `enabled: false` default in `values.yaml`, gate the ExternalSecret entry in `external-secrets.yaml`, and gate the env vars in `api-dep.yaml`.

### Secrets (External Secrets Operator)

`external-secrets.yaml` creates:
1. A `SecretStore` pointing to GCP Secret Manager in `app_project`
2. An `app-secrets` ExternalSecret whose entries are conditionally included based on feature flags (e.g. `stripe.enabled`, `twilio.enabled`, etc.)
3. An `oauth-credentials` ExternalSecret when `google.iap.enabled`

All `remoteRef.key` values match the GCP Secret Manager secret name exactly. Secrets are only rendered when `enabled: true` and `local: false`.

### Database Options

Two mutually exclusive patterns:
- **Cloud SQL proxy** (`db.proxy: true`) — sidecar container in `api-dep` connects to Cloud SQL via IAM auth. Requires `db_project_id` and optionally `db.instance`.
- **In-cluster Postgres** (`postgres.enabled: true`) — CrunchyDB operator. Credentials come from secret `crunchydb-pguser-crunchydb`.

### Ingress

- Default: GKE native ingress (`ingress.enabled: true`, `ingress.mci: false`) with GKE-managed SSL cert (`managed-cert.yaml`) and FrontendConfig for HTTPS redirect.
- Nginx ingress controller: `ingress.nginx: true` — uses cert-manager or GKE-managed certs.
- MultiCluster Ingress: `ingress.mci: true` — uses `multicluster-ingress.yaml` and `multicluster-svc.yaml` instead.
- `ingress.bring_ip: true` — attaches a pre-created static IP (`ip-address.yaml`).

### HPA

`autoscaler.enabled: true` creates HPAs for both `nginx-dep` and `api-dep` using the replica/CPU/memory settings under `nginx.*` and `api.*`.

### CronJobs

`cronjobs.enabled: true` with a `cronjobs.jobs` list. Each job hits an internal API endpoint (`api-svc.{namespace}.svc/api/{endpoint}`) using `httpie`. Per-job `schedule` overrides `cronjobs.default_schedule`. Jobs only render when `enabled: true` within the job entry.
