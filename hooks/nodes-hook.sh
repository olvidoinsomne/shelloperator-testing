#!/usr/bin/env bash
  cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Node
  executeHookOnEvent:
  - Added
EOF