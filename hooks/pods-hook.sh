#!/usr/bin/env bash
  cat <<EOF
configVersion: v1
kubernetes:
- name: periodic-checking
  crontab: "*/5 * * * *"
  includeSnapshotsFrom: ["monitor-pods", "configmap-content"]
kubernetes:
- name: monitor-pods
  kind: Pod
  jqFilter: '.status'
EOF