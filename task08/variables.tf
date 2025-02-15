variable "rg_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "tags" {
  description = "Azure Resource Group Tags"
  type        = map(any)
}

variable "git_pat" {
  description = "Git PAT"
  type        = string
  sensitive   = true
}