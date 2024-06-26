variable "org_name" {
  description = "TFC Organization name."
}

variable "project_name" {
  description = "Project name under TFC Org."
  default     = "*"
}

variable "workspace_name" {
  description = "Workspace name in specified Project."
  default     = "*"
}