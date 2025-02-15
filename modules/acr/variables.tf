variable "rg_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "rg_location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry Name"
  type        = string
}

variable "acr_sku" {
  description = "Azure Container Registry SKU"
  type        = string
}

variable "git_repository_url" {
  description = "GitHub Repository URL"
  type        = string
}

variable "git_repository_branch" {
  description = "GitHub Repository Branch"
  type        = string
}

variable "git_pat" {
  description = "GitHub Personal Access Token"
  type        = string
}

variable "image_name" {
  description = "Azure Container Registry Image Name"
  type        = string
}

variable "tags" {
  description = "Azure Container Registry Tags"
  type        = map(any)
}

