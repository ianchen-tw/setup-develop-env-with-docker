all: docker-build
.PHONY: docker-build

docker-build:
	${MAKE} -C docker