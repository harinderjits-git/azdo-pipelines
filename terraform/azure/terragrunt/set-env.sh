#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
 find . -name .terragrunt-cache -type d -exec rm -rf {} +
 find . -name .terraform -type d -exec rm -rf {} +
## EDIT VALUES BELOW (IF NEEDED) for the ./set-env.sh file generated by
# make setup-set-env

# Assumes logged in to the core platform subscription

# Assumes logged in to the core platform subscription
export ENV_CONFIG_FILE_NAME=config_azdo.yaml
# export TENANT_ID=$(az account show --query tenantId -o tsv)
# export BOOTSTRAP_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
export ORCHESTRATION_PATH=${THIS_DIR}/azdo
export REMOTE_STATE_FILE_NAME=config_remote_state.yaml
#export AD_GROUPS_FILE_NAME=config_main_ad_groups.yaml
#export ALLOW_LIST_CONFIG_FILE_NAME=config_sourcedvpn_allowlist.yaml
## EDIT VALUE ABOVE

export AZDO_PERSONAL_ACCESS_TOKEN=<pat token>
export AZDO_ORG_SERVICE_URL=https://dev.azure.com/<your azdo organization>