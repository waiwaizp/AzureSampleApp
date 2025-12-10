variable "prefix" { default = "myapp" }
variable "location" { default = "West US 2" }
variable "resource_group_name" { default = "rg-myapp" }
variable "admin_username" { default = "mzhang1" }
variable "admin_password" { default = "Zhuhai123!@#" }

variable "vm_size" { default = "Standard_D2s_v3" }
variable "backend_vm_count" { default = 2 }

variable "postgres_username" { default = "pgadmin" }
variable "postgres_password" { default = "Zhuhai123!@#" }

variable "client_secret" { type = string }