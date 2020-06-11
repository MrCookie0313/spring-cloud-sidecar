VERSION := v0.1.0
BUILD := `git rev-parse --short HEAD`
REGISTRY_REPO=registry.sensetime.com/evoa-test


all: image push


.PHONY: image push

image: 
	docker build  -t $(REGISTRY_REPO)/spring-cloud-sidecar:$(VERSION)-$(BUILD) .

push: 
	docker push  $(REGISTRY_REPO)/spring-cloud-sidecar:$(VERSION)-$(BUILD)





