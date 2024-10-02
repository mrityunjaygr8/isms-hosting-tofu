variable "resource_group_name" {
  description = "The name of the resource group to create"
  type        = string
  default     = "example-resource-group"
}

variable "location" {
  description = "The Azure region to create the resource group in"
  type        = string
  default     = "East US"  # Replace with your desired Azure region
}

variable "tags" {
  description = "The tags to apply to the resource group"
  type        = map(string)
  default     = {
    environment = "Production"
    project     = "Example Project"
  }
}
