#!/usr/bin/env bash
  cat <<EOF
configVersion: v1
kubernetes:
- name: node-checking
  crontab: "*/5 * * * *"
  includeSnapshotsFrom: ["monitor-nodes"]
kubernetes:
- name: monitor-nodes
  kind: ["nodes"]
  jqFilter: '.status'
EOF