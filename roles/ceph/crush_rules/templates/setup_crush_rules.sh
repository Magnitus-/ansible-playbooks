#!/bin/sh

set -e

{% if has_ssd %}
if [ -z "$(ceph osd crush rule ls | grep replicated_ssd | { grep -v grep || test $? = 1; })" ]; then
  ceph osd crush rule create-replicated replicated_ssd default host ssd
fi
{% endif %}

if [ -z "$(ceph osd crush rule ls | grep replicated_hdd | { grep -v grep || test $? = 1; })" ]; then
  ceph osd crush rule create-replicated replicated_hdd default host hdd
fi

if [ -z "$(ceph osd pool get .mgr crush_rule | grep {{ mgr_crush_rule }} | { grep -v grep || test $? = 1; })"]; then
  ceph osd pool set .mgr crush_rule {{ mgr_crush_rule }}
fi