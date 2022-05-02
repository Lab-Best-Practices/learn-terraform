########## General ###############
variable "name" {
  default     = ""
  type        = string
  description = "The name of the Linux Virtual Machine. Changing this forces a new resource to be created."
}

variable "location" {
  default     = ""
  type        = string
  description = "The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  default     = ""
  type        = string
  description = "The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created."
}

variable "network_interface_ids" {
  #default     = ""
  type        = list(string)
  description = " A list of Network Interface ID's which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine."
}

variable "size" {
  default     = ""
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

############ Disk ############

variable "disk_name" {
  default     = ""
  type        = string
  description = "The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
}

variable "caching" {
  default     = ""
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
}

variable "storage_account_type" {
  default     = ""
  type        = string
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created."
}

############ Source image ###########
## you can get on Azure portal via Download template

variable "publisher" {
  default     = ""
  type        = string
  description = "Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created."
}

variable "offer" {
  default     = ""
  type        = string
  description = "Specifies the offer of the image used to create the virtual machines."
}

variable "sku" {
  default     = ""
  type        = string
  description = "Specifies the SKU of the image used to create the virtual machines."
}

variable "version_img" {
  default     = "lastest"
  type        = string
  description = "Specifies the version of the image used to create the virtual machines."
}

########## Computer infor #############

variable "computer_name" {
  # we just use 15 character
  default     = ""
  type        = string
  description = "Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created."
}

variable "admin_username" {
  default     = ""
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "disable_password_authentication" {
  default     = "false"
  type        = bool
  description = "Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
}

variable "admin_password" {
  # password P@$$w0rd1234!
  default     = "P@$$w0rd1234!"
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
}