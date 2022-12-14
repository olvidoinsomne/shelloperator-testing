#!/usr/bin/env bash

  cat <<EOF
configVersion: v1
kubernetes:
- name: periodic-checking
  crontab: "*/5 * * * *"
  includeSnapshotsFrom: ["monitor-master", "configmap-content"]
kubernetes:
- name: configmap-content
  kind: ConfigMap
  nameSelector:
    matchNames: ["jonesweb-configs"]
  executeHookOnSynchronization: false
  executeHookOnEvent: ["Added","Modified", "Deleted"]
- name: monitor-master
  kind: "*" 
  jqFilter: '.status'
  includeSnapshotsFrom: ["configmap-content"] 
EOF
