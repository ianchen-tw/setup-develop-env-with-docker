all: build
.PHONY: build activate

# Do not named user and group the same, this would cause error in entrypoint.sh
#	because we create the group before user exist which allowing name-crash in useradd command
CONTAINER_USERNAME = ian
CONTAINER_GROUPNAME = iang
CONTAINER_HOSTNAME = dev-env
IMAGE_NAME ?= my-dev-env

HOMEDIR = /home/${CONTAINER_USERNAME}

build: Dockerfile
	docker build \
		--build-arg CONTAINER_USERNAME=${CONTAINER_USERNAME} \
		--build-arg CONTAINER_GROUPNAME=${CONTAINER_GROUPNAME} \
		--build-arg CONTAINER_HOMEDIR=${HOMEDIR} \
		-t $(IMAGE_NAME) .

activate:
	python3 activate_docker.py \
		--username ${CONTAINER_USERNAME} \
		--homedir ${HOMEDIR} \
		--imagename ${IMAGE_NAME} \
		--hostname ${CONTAINER_HOSTNAME}