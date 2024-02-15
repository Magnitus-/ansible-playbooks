#!/bin/sh

set -e

if [ ! -z "$(ceph orch ls | grep ingress.rgw.default | { grep -v grep || test $? = 1; })" ]; then
  ceph orch rm ingress.rgw.default;
fi

if [ ! -z "$(ceph orch ls | grep rgw.default | { grep -v grep || test $? = 1; })" ]; then
  ceph orch rm rgw.default;
fi

while [ ! -z "$(ceph orch ls | grep ingress.rgw.default | { grep -v grep || test $? = 1; })" ]; do
  sleep 10
done

while [ ! -z "$(ceph orch ls | grep rgw.default | { grep -v grep || test $? = 1; })" ]; do
  sleep 10
done