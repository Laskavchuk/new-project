PLATFORMS = linux/amd64 windows/amd64 darwin/amd64 linux/arm64
IMAGE_NAME = ttl.sh/mytestimage
TAG ?= latest

all: image

image:
	docker buildx build \
		--load \
		--platform=$(shell docker info --format '{{.OSType}}' | sed 's/linux/linux\/amd64/') \
		-t $(IMAGE_NAME):$(TAG) .

linux:
	docker buildx build --platform linux/amd64 -t $(IMAGE_NAME):linux --push .

windows:
	docker buildx build --platform windows/amd64 -t $(IMAGE_NAME):windows --push .

macos:
	docker buildx build --platform darwin/amd64 -t $(IMAGE_NAME):macos --push .

arm:
	docker buildx build --platform linux/arm64 -t $(IMAGE_NAME):arm --push .

clean:
	-docker rmi $(IMAGE_NAME):$(TAG) || true
	-docker rmi $(IMAGE_NAME):linux || true
	-docker rmi $(IMAGE_NAME):windows || true
	-docker rmi $(IMAGE_NAME):macos || true
	-docker rmi $(IMAGE_NAME):arm || true