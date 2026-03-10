# Control variables for resource creation
variable "create_instance" {
  description = "Whether to create a new OTS instance. If false, an existing instance ID must be provided."
  type        = bool
  default     = true
}

variable "create_instance_attachment" {
  description = "Whether to create OTS instance VPC attachment."
  type        = bool
  default     = false
}

variable "create_table" {
  description = "Whether to create a table in the OTS instance."
  type        = bool
  default     = false
}

variable "create_search_index" {
  description = "Whether to create a search index for the OTS table."
  type        = bool
  default     = false
}

variable "create_secondary_index" {
  description = "Whether to create a secondary index for the OTS table."
  type        = bool
  default     = false
}

variable "create_tunnel" {
  description = "Whether to create a tunnel for the OTS table."
  type        = bool
  default     = false
}

# External resource IDs (used when create_xxx = false)
variable "instance_id" {
  description = "The ID of an existing OTS instance. Required when create_instance is false."
  type        = string
  default     = null
}

variable "table_id" {
  description = "The ID of an existing OTS table. Required when create_table is false."
  type        = string
  default     = null
}

# OTS instance configuration
variable "instance_config" {
  description = "The parameters of OTS instance. The attribute 'name' is required."
  type = object({
    name               = string
    description        = optional(string, null)
    accessed_by        = optional(string, "Any")
    instance_type      = optional(string, "HighPerformance")
    network_type_acl   = optional(list(string), null)
    network_source_acl = optional(list(string), null)
    resource_group_id  = optional(string, null)
    tags               = optional(map(string), {})
  })
  default = {
    name = null
  }
}

# OTS instance VPC attachment configuration
variable "instance_attachment_config" {
  description = "The parameters of OTS instance VPC attachment. The attributes 'vpc_name' and 'vswitch_id' are required."
  type = object({
    vpc_name   = string
    vswitch_id = string
  })
  default = {
    vpc_name   = null
    vswitch_id = null
  }
}

# OTS table configuration
variable "table_config" {
  description = "The parameters of OTS table. The attributes 'table_name', 'time_to_live', 'max_version' and 'primary_keys' are required."
  type = object({
    table_name                    = string
    time_to_live                  = number
    max_version                   = number
    allow_update                  = optional(bool, true)
    deviation_cell_version_in_sec = optional(number, 86400)
    enable_sse                    = optional(bool, false)
    sse_key_type                  = optional(string, null)
    sse_key_id                    = optional(string, null)
    sse_role_arn                  = optional(string, null)
    primary_keys = list(object({
      name = string
      type = string
    }))
    defined_columns = optional(list(object({
      name = string
      type = string
    })), [])
  })
  default = {
    table_name   = null
    time_to_live = null
    max_version  = null
    primary_keys = []
  }
}

# OTS search index configuration
variable "search_index_config" {
  description = "The parameters of OTS search index. The attributes 'index_name' and 'field_schemas' are required."
  type = object({
    index_name   = string
    time_to_live = optional(number, -1)
    field_schemas = list(object({
      field_name          = string
      field_type          = string
      is_array            = optional(bool, false)
      index               = optional(bool, true)
      analyzer            = optional(string, null)
      enable_sort_and_agg = optional(bool, false)
      store               = optional(bool, false)
    }))
    index_setting = optional(object({
      routing_fields = optional(list(string), [])
    }), null)
    index_sort = optional(object({
      sorters = list(object({
        sorter_type = optional(string, "PrimaryKeySort")
        order       = optional(string, "Asc")
        field_name  = optional(string, null)
        mode        = optional(string, null)
      }))
    }), null)
  })
  default = {
    index_name    = null
    field_schemas = []
  }
}

# OTS secondary index configuration
variable "secondary_index_config" {
  description = "The parameters of OTS secondary index. The attributes 'index_name', 'index_type', 'include_base_data' and 'primary_keys' are required."
  type = object({
    index_name        = string
    index_type        = string
    include_base_data = bool
    primary_keys      = list(string)
    defined_columns   = optional(list(string), [])
  })
  default = {
    index_name        = null
    index_type        = null
    include_base_data = null
    primary_keys      = []
  }
}

# OTS tunnel configuration
variable "tunnel_config" {
  description = "The parameters of OTS tunnel. The attributes 'tunnel_name' and 'tunnel_type' are required."
  type = object({
    tunnel_name = string
    tunnel_type = string
  })
  default = {
    tunnel_name = null
    tunnel_type = null
  }
}