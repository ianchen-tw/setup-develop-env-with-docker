all: build
.PHONY: build

DOCKER_USER_NAME = yian
IMG_NAME = my-test-env

build: Dockerfile
	docker build -t $(IMG_NAME) .