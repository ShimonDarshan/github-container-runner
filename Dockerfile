FROM ubuntu:26.10

ARG RUNNER_VERSION
ARG RUNNER_SHA256

WORKDIR /actions-runner

# Install dependencies
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        libdigest-sha-perl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o runner.tar.gz \
        https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    echo "${RUNNER_SHA256}  runner.tar.gz" | shasum -a 256 -c && \
    tar xzf runner.tar.gz && \
    rm runner.tar.gz

RUN ./bin/installdependencies.sh && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown -R ubuntu:ubuntu /actions-runner

# config.sh / run.sh refuse to run as root
USER ubuntu

ENTRYPOINT ["/entrypoint.sh"]
