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
  kind: ["clusterroles,componentstatuses,configmaps,cronjobs,daemonsets,deployments,endpoints,events,ingresses,limitranges,namespaces,nodes,persistentvolumeclaims,persistentvolumes,pods,podtemplates,replicasets,replicationcontrollers,resourcequotas,rolebindings,roles,secrets,serviceaccounts,servicemonitors,services"]
  jqFilter: '.status'
  includeSnapshotsFrom: ["configmap-content"] 
EOF
