
variable "project_name" {
  type = string

  default = "project1"
}

variable "pipeline_name" {
  type = string

  default = "project1-pipeline1"
}

variable "repo_name" {
  type = string

  default = "project1-repo1"
}
variable "vg_name" {
  type = string


}


variable "variables" {
  type = map(object({
    name      = string
    equalto   = string
    is_secret = bool
  }))

}
