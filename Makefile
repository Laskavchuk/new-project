REGISTRY := quay.io/max
APP_NAME := multi-platform-app
IMAGE_TAG := latest
FULL_IMAGE_NAME := $(REGISTRY)/$(APP_NAME)

HOST_OS := $(shell go env GOOS)
HOST_ARCH := $(shell go env GOARCH)

.PHONY: all image clean test linux macos macos-arm windows arm

all: image

image:
	@echo "--> Створення Docker-образу для $(HOST_OS)/$(HOST_ARCH)..."
	docker build \
		--build-arg TARGETOS=$(HOST_OS) \
		--build-arg TARGETARCH=$(HOST_ARCH) \
		-t $(FULL_IMAGE_NAME):$(IMAGE_TAG) .
	@echo "--> Образ створено: $(FULL_IMAGE_NAME):$(IMAGE_TAG)"

linux:
	@echo "--> Створення образу для linux/amd64..."
	docker build \
		--build-arg TARGETOS=linux \
		--build-arg TARGETARCH=amd64 \
		-t $(FULL_IMAGE_NAME):linux-amd64 .
	@echo "--> Образ створено: $(FULL_IMAGE_NAME):linux-amd64"

macos:
	@echo "--> Створення образу для darwin/amd64 (macOS Intel)..."
	docker build \
		--build-arg TARGETOS=darwin \
		--build-arg TARGETARCH=amd64 \
		-t $(FULL_IMAGE_NAME):macos-amd64 .
	@echo "--> Образ створено: $(FULL_IMAGE_NAME):macos-amd64"

macos-arm:
	@echo "--> Створення образу для darwin/arm64 (macOS Apple Silicon)..."
	docker build \
		--build-arg TARGETOS=darwin \
		--build-arg TARGETARCH=arm64 \
		-t $(FULL_IMAGE_NAME):macos-arm64 .
	@echo "--> Образ створено: $(FULL_IMAGE_NAME):macos-arm64"

windows:
	@echo "--> Створення образу для windows/amd64..."
	docker build \
		--build-arg TARGETOS=windows \
		--build-arg TARGETARCH=amd64 \
		-t $(FULL_IMAGE_NAME):windows-amd64 .
	@echo "--> Образ створено: $(FULL_IMAGE_NAME):windows-amd64"

arm:
	@echo "--> Створення образу для linux/arm64..."
	docker build \
		--build-arg TARGETOS=linux \
		--build-arg TARGETARCH=arm64 \
		-t $(FULL_IMAGE_NAME):linux-arm64 .
	@echo "--> Образ створено: $(FULL_IMAGE_NAME):linux-arm64"

test:
	@echo "--> Запуск тестів у Docker..."
	docker build --target test -t $(FULL_IMAGE_NAME):test .
	@echo "--> Тести завершено."

clean:
	@echo "--> Видалення образу $(FULL_IMAGE_NAME):$(IMAGE_TAG)..."
	docker rmi $(FULL_IMAGE_NAME):$(IMAGE_TAG) || true
	@echo "--> Очищення завершено."
