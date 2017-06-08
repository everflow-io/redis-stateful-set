FROM library/redis:3.2
MAINTAINER Olivier Boucher <olivier@everflow.io>

COPY ["docker-entrypoint.sh", "/usr/local/bin/"]
