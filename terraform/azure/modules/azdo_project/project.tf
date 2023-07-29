resource "azuredevops_project" "example" {
  name               = var.project_name
  visibility         = var.visibility
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "${var.project_name} Managed by Terraform"
  features = {
    "testplans" = "disabled"
    "artifacts" = "disabled"
  }
}




resource "azuredevops_variable_group" "example" {
  for_each     = var.variable_groups
  project_id   = azuredevops_project.example.id
  name         = each.value.name
  description  = "${each.value.name} Variable Group Description"
  allow_access = true
  dynamic "variable" {
    for_each = each.value.variables
    content {
      name      = variable.value.name
      value     = variable.value.equalto
      is_secret = false

    }

  }

}


resource "azuredevops_agent_pool" "example" {
  name           = var.agent_pool
  auto_provision = false
  auto_update    = false
}



resource "azuredevops_agent_queue" "example" {
  project_id    = azuredevops_project.example.id
  agent_pool_id = azuredevops_agent_pool.example.id
}

# Grant access to queue to all pipelines in the project
resource "azuredevops_pipeline_authorization" "example" {
  project_id  = azuredevops_project.example.id
  resource_id = azuredevops_agent_queue.example.id
  type        = "queue"
}
