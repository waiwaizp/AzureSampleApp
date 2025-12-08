variable "prefix" { default = "myapp" }
variable "location" { default = "West US 2" }
variable "resource_group_name" { default = "rg-myapp" }
variable "admin_username" { default = "azureuser" }
variable "ssh_public_key" { type = string }

variable "vm_size" { default = "SStandard_D2s_v3" }
variable "backend_vm_count" { default = 2 }

variable "domain_name" { description = "e.g. example.com" }
variable "postgres_password" { type = string }
