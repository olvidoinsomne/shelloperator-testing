#!/usr/bin/env bash
  cat <<EOF
configVersion: v1
kubernetes:
- name: node-checking
  crontab: "*/5 * * * *"
  includeSnapshotsFrom: ["monitor-master"]
kubernetes:
- name: monitor-master
  kind: ["nodes"]
  jqFilter: '.status'
EOF