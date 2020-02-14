FROM ubuntu:18.04

ARG PYTHON3_VERSION=3.8

RUN apt-get update \
    && apt-get install gosu \
    && apt-get install -y software-properties-common && add-apt-repository -y ppa:deadsnakes/ppa \
        && apt-get install -y python${PYTHON3_VERSION} \
        && ln -sfn /usr/bin/python${PYTHON3_VERSION} /usr/bin/python3 \
        && ln -sfn /usr/bin/python${PYTHON3_VERSION} /usr/bin/python


RUN apt-get install -y gosu make

ARG CONTAINER_USERNAME=dummy
ARG CONTAINER_GROUPNAME=dummyg
ARG CONTAINER_HOMEDIR=/home/dummy

ENV DOCKER_USERNAME_PASSIN ${CONTAINER_USERNAME}
ENV DOCKER_GROUPNAME_PASSIN ${CONTAINER_GROUPNAME}
ENV DOCKER_HOMEDIR_PASSIN ${CONTAINER_HOMEDIR}

# indicate we are inside docker
ENV STATUS_DOCKER_ACTIVATED 1

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]