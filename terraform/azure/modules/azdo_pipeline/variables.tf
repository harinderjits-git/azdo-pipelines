
variable "project_name" {
  type = string

  default = "project1"
}



variable "pipelines" {
  type = map(object({
    name            = string
    associated_repo = string
    variable_group  = string
    variables = map(object({
      name      = string
      equalto   = string
      is_secret = bool
    }))
    }
  ))
}
