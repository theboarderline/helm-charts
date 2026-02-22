

all: test

test: lint template unit

template:
	helm template test . -f ./test-values.yaml -n test-ns > test-output.yaml
	git diff test-output.yaml

lint:
	helm lint .

unit:
	helm unittest .

