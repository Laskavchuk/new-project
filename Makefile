IMAGE_NAME=my-product
VERSION=latest
PLATFORMS = linux/amd64 linux/arm64 darwin/amd64 darwin/arm64 windows/amd64

.PHONY: all clean linux arm macos windows

linux:
	docker build --platform=linux/amd64 -t $(IMAGE_NAME):linux .

arm:
	docker build --platform=linux/arm64 -t $(IMAGE_NAME):arm .

macos:
	docker build --platform=darwin/arm64 -t $(IMAGE_NAME):macos .

windows:
	docker build --platform=windows/amd64 -t $(IMAGE_NAME):windows .

clean:
	docker rmi $(IMAGE_NAME):linux || true
	docker rmi $(IMAGE_NAME):arm || true
	docker rmi $(IMAGE_NAME):macos || true
	docker rmi $(IMAGE_NAME):windows || true