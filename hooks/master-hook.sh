#!/usr/bin/env bash
if [[ $1 == "--config" ]] ; then
cat <<EOF
configVersion: v1
kubernetes:
- name: periodic-checking
  crontab: "*/5 * * * *"
  includeSnapshotsFrom: ["monitor-pods"]
kubernetes:
- name: monitor-pods
  kind: nodes
  jqFilter: '.status'
EOF
else
  kubectlPath=$(which kubectl);
  nodeUpdate=$(echo "nodeCount: $($kubectlPath get nodes -o jsonpath='{.items[*]}' | jq '.kind'| wc -l | awk '{ print $NF }')");
  clusterName=$(k get node -ojson | jq -r '.items[1].metadata.labels."kubernetes.azure.com/cluster"'| sed 's/_/|/g' |awk -F "|" '{print $3}' )
  echo "cluster: $clusterName,$nodeUpdate"
fi