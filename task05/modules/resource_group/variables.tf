variable "name" {
  type        = string
  description = "The name of the Resource Group"
}

variable "location" {
  type        = string
  description = "The location of the Resource Group"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the Resource Group"
}
