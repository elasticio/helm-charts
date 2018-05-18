.PHONY: $(sort $(dir $(wildcard */)))

all: clean

fluentd: lint-fluentd build-fluentd

lint-%:
	helm lint $*

build-%:
	if [ -f $*/requirements.yml ]; then helm dependency update $*; fi
	helm package -d docs $*

clean:
	find . -name "*.tgz" -exec rm '{}' +
