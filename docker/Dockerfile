FROM ubuntu:19.04

# Combine all three RUNs into 1 in deloyment
RUN apt-get update && apt-get --no-install-recommends install -y \
    gosu \
    fish \
    python3 python3-pip python3-setuptools python3-wheel
    # && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
