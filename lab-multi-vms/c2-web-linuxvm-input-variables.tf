# Linux VM Input Variables Placeholder file.

variable "computer_name" { 
    type = string
    default = "web-linux-vm" 
}

variable "instance_size" { 
    type = string
    default  = "Standard_DS1_v2" 
}

variable "admin_username" { 
    type = string
    default = "azureuser" 
}

variable "os_disc_storage_type" { 
    type = string
    default = "Standard_LRS" 
}

variable "web_linuxvm_instance_count" {
  description = "Web Linux VM Instance Count"
  type = map(string)
  default = {
    "vm1" = "1022",
    "vm2" = "2022"
  }
}