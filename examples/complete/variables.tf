variable "region" {
  description = "The Alicloud region to deploy resources in"
  type        = string
  default     = "cn-hangzhou"
}

variable "create_instance" {
  description = "Whether to create OTS instance"
  type        = bool
  default     = true
}

variable "create_vpc" {
  description = "Whether to create VPC and VSwitch for OTS instance attachment"
  type        = bool
  default     = false
}

variable "create_instance_attachment" {
  description = "Whether to create OTS instance VPC attachment"
  type        = bool
  default     = false
}

variable "create_table" {
  description = "Whether to create OTS table"
  type        = bool
  default     = true
}

variable "create_search_index" {
  description = "Whether to create OTS search index"
  type        = bool
  default     = true
}

variable "create_secondary_index" {
  description = "Whether to create OTS secondary index"
  type        = bool
  default     = true
}

variable "create_tunnel" {
  description = "Whether to create OTS tunnel"
  type        = bool
  default     = true
}

variable "instance_name" {
  description = "The name of the OTS instance"
  type        = string
  default     = "otsexample-full"
}

variable "table_name" {
  description = "The name of the OTS table"
  type        = string
  default     = "example_table"
}