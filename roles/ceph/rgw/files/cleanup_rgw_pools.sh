#!/bin/sh

set -e

ceph tell mon.* injectargs --mon_allow_pool_delete true

#Control pool
if [ ! -z "$(ceph osd pool ls | grep default.rgw.control | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.control default.rgw.control --yes-i-really-really-mean-it
fi

#Meta pool
if [ ! -z "$(ceph osd pool ls | grep default.rgw.meta | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.meta default.rgw.meta --yes-i-really-really-mean-it
fi

#Log pool
if [ ! -z "$(ceph osd pool ls | grep default.rgw.log | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.log default.rgw.log --yes-i-really-really-mean-it
fi

#Otp pool
if [ ! -z "$(ceph osd pool ls | grep default.rgw.otp | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.otp default.rgw.otp --yes-i-really-really-mean-it
fi

#Default placement group index pool
if [ ! -z "$(ceph osd pool ls | grep default.rgw.buckets.index | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.buckets.index default.rgw.buckets.index --yes-i-really-really-mean-it
fi

#Default placement group extra data pool
if [ ! -z "$(ceph osd pool ls | grep default.rgw.buckets.non-ec | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.buckets.non-ec default.rgw.buckets.non-ec --yes-i-really-really-mean-it
fi

#Default placement group standard storage class
if [ ! -z "$(ceph osd pool ls | grep default.rgw.buckets.data | { grep -v grep || test $? = 1; })" ]; then
  ceph osd pool rm default.rgw.buckets.data default.rgw.buckets.data --yes-i-really-really-mean-it
  ceph osd erasure-code-profile rm default-ec
fi

#Root pool
if [ ! -z "$(ceph osd pool ls | grep .rgw.root | { grep -v grep || test $? = 1; })" ]; then
    ceph osd pool rm .rgw.root .rgw.root --yes-i-really-really-mean-it
fi

ceph tell mon.* injectargs --mon_allow_pool_delete false