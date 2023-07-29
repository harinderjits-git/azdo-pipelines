resource "azuredevops_git_repository" "example" {
  for_each   = var.repos
  project_id = azuredevops_project.example.id
  name       = each.value.name

  initialization {
    init_type   = each.value.init_type
    source_type = "Git"
    source_url  = each.value.imported_from
  }
}

output "id" {
  value = azuredevops_git_repository.example
}
