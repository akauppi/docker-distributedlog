TAG=latest

.PHONY: build
build:
	docker build -t us.gcr.io/fcuny-devel/distributedlog:$(TAG) .

.PHONY: push
push:
	gcloud docker -- push us.gcr.io/fcuny-devel/distributedlog:$(TAG)

.PHONY: all
all: build push
