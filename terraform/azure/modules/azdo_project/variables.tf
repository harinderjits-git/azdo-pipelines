
variable "project_name" {
  type = string

  default = "project1"
}

variable "pipeline_name" {
  type = string

  default = "project1-pipeline1"
}


variable "imported_from" {
  type = string

  default = "https://github.com/harinderjits-git/gitops-azdevops.git"
}
variable "visibility" {
  type    = string
  default = "private"
}
variable "agent_pool" {
  type    = string
  default = "Newlocal"
}
variable "environments" {
  type = map(map(string))
}

variable "variable_groups" {
  type = map(object({
    name = string
    variables = map(object({
      name      = string
      equalto   = string
      is_secret = bool
    }))
    }
  ))
}



variable "repos" {
  type = map(object({
    name          = string
    init_type     = string
    imported_from = string
  }))

}
