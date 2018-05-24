.PHONY: $(sort $(dir $(wildcard */)))

all: build

admiral: build-admiral
api: build-api
cluster: build-cluster
fluentd: build-fluentd
frontend: build-frontend
gitreceiver: build-gitreceiver
lookout: build-lookout
platform-storage-slugs: build-platform-storage-slugs
scheduler: build-scheduler
steward: build-steward
webhooks: build-webhooks

lint: lint-admiral lint-api lint-cluster lint-fluentd lint-frontend lint-gitreceiver
lint: lint-lookout lint-platform-storage-slugs lint-scheduler
lint: lint-steward lint-webhooks
lint-%:
	helm lint $*

build: build-admiral build-api build-cluster build-fluentd build-frontend build-gitreceiver
build: build-lookout build-platform-storage-slugs build-scheduler
build: build-steward build-webhooks
build-%:
	if [ -f $*/requirements.yaml ]; then helm dependency update $*; fi
	helm package -d docs $*
	helm repo index docs --url https://docs.elastic.io/helm-charts

clean:
	find . -name "*.tgz" -exec rm '{}' +
