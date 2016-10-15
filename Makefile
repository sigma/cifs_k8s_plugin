IMAGE=sigma/cifs_k8s_plugin
BUILDER=$(IMAGE)_builder
VERSION := $(shell git describe --always --dirty --tags)

container:
	docker build -f builder.Dockerfile -t $(BUILDER) .
	docker run $(BUILDER) | docker build -t $(IMAGE) -

push: container
	docker tag $(IMAGE) $(IMAGE):$(VERSION)
	docker tag $(IMAGE) $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest