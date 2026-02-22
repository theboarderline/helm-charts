

all: test diff

test: lint unit

.PHONY: lint
lint:
	@echo "🔍 Linting Helm chart..."
	@helm lint .


.PHONY: unit
unit:
	@echo "🧪 Running unit tests..."
	@helm unittest .


.PHONY: template
template:
	@echo "📄 Generating Helm template output..."
	@helm template test . -f ./test-values.yaml -n test-ns > test-output.yaml


.PHONY: diff
diff: template
	@echo "🔍 Comparing generated output with expected output..."
	@git diff test-output.yaml
