.PHONY: $(sort $(dir $(wildcard */)))

all: fluentd

fluentd: lint-fluentd build-fluentd

lint-%:
	helm lint $*

build-%:
	if [ -f $*/requirements.yml ]; then helm dependency update $*; fi
	helm package -d docs $*
	helm repo index docs --url https://helm-charts.elastic.io

clean:
	find . -name "*.tgz" -exec rm '{}' +
