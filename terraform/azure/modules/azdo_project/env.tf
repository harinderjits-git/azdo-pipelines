

resource "azuredevops_environment" "example" {
  for_each   = var.environments
  project_id = azuredevops_project.example.id
  name       = each.value.name
}

data "azuredevops_users" "example" {
  principal_name = "hainderjitss@outlook.com"
}

resource "azuredevops_group" "example" {
  display_name = "some-azdo-group"
}

resource "azuredevops_check_approval" "example" {
  project_id           = azuredevops_project.example.id
  target_resource_id   = azuredevops_environment.example["env1"].id
  target_resource_type = "environment"

  requester_can_approve = true
  approvers = [
    azuredevops_group.example.origin_id,
  ]
}
