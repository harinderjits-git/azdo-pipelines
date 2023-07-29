locals {
 # platform_config = yamldecode(file(format("%s/%s", get_env("MAIN_CONFIG_PATH"), get_env("MAIN_CONFIG_FILE_NAME"))))
  env_config      = yamldecode(file(format("%s/%s", get_env("ORCHESTRATION_PATH"), get_env("ENV_CONFIG_FILE_NAME"))))
  subscription_id = local.env_config.subscriptions.prod_workloads[0].id # This is the line to update to point to the proper sub
}

terraform {
  source = "../../../../modules/azdo_project"
}


inputs = {
  project_name = local.env_config.projects.project1.name
  variable_groups=local.env_config.projects.project1.variable_groups
  repos=local.env_config.projects.project1.repos
  environments=local.env_config.projects.project1.environments
  agent_pool=local.env_config.projects.project1.agent_pool
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.7.0"
    }
  }
}

provider "azuredevops" {
  # Configuration options
}

EOF
}

include {
  path = find_in_parent_folders()
}
