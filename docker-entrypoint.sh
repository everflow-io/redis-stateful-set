#!/bin/bash

set -e
set -x

echo "bind 0.0.0.0" > /etc/redis.conf
echo "protected-mode no" >> /etc/redis.conf

set -- $(which redis-server) /etc/redis.conf

if [ -v REPLICA ] && [ ! -v SENTINEL ]; then
  set -- $@ --slaveof $(redis-cli -h redis-sentinel -p 26379 --raw sentinel get-master-addr-by-name master | sed -n 1p) 6379
fi

if [ -v SENTINEL ]; then
	echo "sentinel monitor master $SENTINEL 6379 2" >> /etc/redis.conf
	echo "sentinel down-after-milliseconds master 5000" >> /etc/redis.conf
	echo "sentinel failover-timeout master 10000" >> /etc/redis.conf
	echo "sentinel parallel-syncs master 1" >> /etc/redis.conf

	set -- $@ --port 26379 --sentinel
fi

cat /etc/redis.conf

exec "$@"
