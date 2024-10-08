FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Lisbon

RUN apt-get update && apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && bash nodesource_setup.sh && \
    apt install -y nodejs && apt-get install -y chromium-browser && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN npm install -g haxroomie-cli

COPY root/ /scripts/

CMD ["/scripts/bootstrap.sh"]

HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /scripts/healthcheck.sh || exit 1
