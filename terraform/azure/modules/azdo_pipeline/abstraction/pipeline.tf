

data "azuredevops_project" "example" {
  name = var.project_name
}

data "azuredevops_git_repository" "example" {
  name       = var.repo_name
  project_id = data.azuredevops_project.example.id
}


data "azuredevops_variable_group" "example" {
  name       = var.vg_name
  project_id = data.azuredevops_project.example.id

}

resource "azuredevops_project_pipeline_settings" "example" {
  project_id = data.azuredevops_project.example.id

  enforce_job_scope                    = true
  enforce_referenced_repo_scoped_token = false
  enforce_settable_var                 = true
  publish_pipeline_metadata            = false
  status_badges_are_private            = true
}

resource "azuredevops_build_definition" "example" {

  project_id = data.azuredevops_project.example.id
  name       = var.pipeline_name

  ci_trigger {
    use_yaml = true
  }

  schedules {
    branch_filter {
      include = ["master"]
      exclude = ["test", "regression"]
    }
    days_to_build              = ["Wed", "Sun"]
    schedule_only_with_changes = true
    start_hours                = 10
    start_minutes              = 59
    time_zone                  = "(UTC) Coordinated Universal Time"
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = data.azuredevops_git_repository.example.id
    branch_name = data.azuredevops_git_repository.example.default_branch
    yml_path    = "azure-pipelines.yml"
  }

  variable_groups = [
    data.azuredevops_variable_group.example.id
  ]
  dynamic "variable" {
    for_each = var.variables
    content {
      name           = variable.value.name
      value          = variable.value.equalto
      is_secret      = false
      allow_override = true
    }
  }
}
