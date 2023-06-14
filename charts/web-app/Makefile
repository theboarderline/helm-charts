

all: test

test:
	helm template test . -f ./test-values.yaml -n test-ns > test-output.yaml
	git diff test-output.yaml

