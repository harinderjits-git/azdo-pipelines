
locals {
  env_config      = yamldecode(file(format("%s/%s", get_env("ORCHESTRATION_PATH"), get_env("ENV_CONFIG_FILE_NAME"))))
  # save tfstate to path from 'orchestration', irregardless of the relative path from the current dir
  tfstate_key = replace(get_terragrunt_dir(), get_env("ORCHESTRATION_PATH"), "azdo")
}

# Remote State Configuration
remote_state {
  # Disabling since it's causing issues as per
  # https://github.com/gruntwork-io/terragrunt/pull/1317#issuecomment-682041007
  disable_dependency_optimization = true

  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    tenant_id       = local.env_config.global.tenant_id
    subscription_id = local.env_config.subscriptions.prod_workloads[0].id

    resource_group_name  = local.env_config.global.azdo_remote_state.rg_name
    storage_account_name = local.env_config.global.azdo_remote_state.storage_account
    container_name       = local.env_config.global.azdo_remote_state.container_name

    key = "${local.tfstate_key}/terraform.tfstate"

    snapshot = true
  }
}
