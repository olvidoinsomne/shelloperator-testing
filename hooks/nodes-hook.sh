#!/usr/bin/env bash
  cat <<EOF
configVersion: v1
kubernetes:
- name: node-checking
  crontab: "*/5 * * * *"
  includeSnapshotsFrom: ["monitor-master", "configmap-content"]
kubernetes:
- name: configmap-content
  kind: ConfigMap
  nameSelector:
    matchNames: ["jonesweb-configs"]
  executeHookOnSynchronization: true
  executeHookOnEvent: ["Added","Modified", "Deleted"]
- name: monitor-master
  kind: ["nodes"]
  jqFilter: '.status'
  includeSnapshotsFrom: ["configmap-content"] 
EOF