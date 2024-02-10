#!/bin/sh

set -e

while [ "$(ceph orch device ls | grep No | { grep -v grep || test $? = 1; } | wc -l)" = "0" ]; do
  sleep 10
done

while [ "$(ceph orch device ls | grep Yes | { grep -v grep || test $? = 1; } | wc -l)" != "0" ]; do
  sleep 10
done

{% if use_device_classes and has_ssd %}
if [ -z "$(ceph osd crush rule ls | grep replicated_ssd | { grep -v grep || test $? = 1; })" ]; then
  ceph osd crush rule create-replicated replicated_ssd default host ssd
fi
{% endif %}

{% if use_device_classes %}
if [ -z "$(ceph osd crush rule ls | grep replicated_hdd | { grep -v grep || test $? = 1; })" ]; then
  ceph osd crush rule create-replicated replicated_hdd default host hdd
fi
{% endif %}

if [ -z "$(ceph osd pool get .mgr crush_rule | grep {{ mgr_crush_rule }} | { grep -v grep || test $? = 1; })"]; then
  ceph osd pool set .mgr crush_rule {{ mgr_crush_rule }}
fi