#!/bin/bash

set -e

# Configure Bash
cat <<EOF >> /home/vscode/.bashrc
source <(fzf --bash)
EOF

cat <<EOF >> terraform.tfvars
temporal_cloud_api_key            = "<temporal_cloud_api_key>"
temporal_cloud_allowed_account_id = "<temporal_cloud_allowed_account_id>"
EOF