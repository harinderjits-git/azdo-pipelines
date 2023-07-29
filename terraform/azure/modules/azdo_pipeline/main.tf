module "pipelines" {
  for_each      = var.pipelines
  source        = "./abstraction"
  project_name  = var.project_name
  repo_name     = each.value.associated_repo
  variables     = each.value.variables
  pipeline_name = each.value.name
  vg_name       = each.value.variable_group
}

