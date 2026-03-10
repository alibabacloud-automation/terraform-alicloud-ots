# Local variables for resource IDs - support both creating new resources or using existing ones
locals {
  # OTS instance ID - use created instance or provided external instance ID
  this_ots_instance_id = var.create_instance ? alicloud_ots_instance.instance[0].id : var.instance_id

  # OTS table ID - use created table or provided external table ID
  this_ots_table_id = var.create_table ? alicloud_ots_table.table[0].id : var.table_id
}

# OTS instance (optional creation)
resource "alicloud_ots_instance" "instance" {
  count              = var.create_instance ? 1 : 0
  name               = var.instance_config.name
  description        = var.instance_config.description
  accessed_by        = var.instance_config.accessed_by
  instance_type      = var.instance_config.instance_type
  network_type_acl   = var.instance_config.network_type_acl != null ? var.instance_config.network_type_acl : null
  network_source_acl = var.instance_config.network_source_acl != null ? var.instance_config.network_source_acl : null
  resource_group_id  = var.instance_config.resource_group_id
  tags               = var.instance_config.tags
}

# OTS instance VPC attachment (optional creation)
resource "alicloud_ots_instance_attachment" "attachment" {
  count         = var.create_instance_attachment ? 1 : 0
  instance_name = local.this_ots_instance_id
  vpc_name      = var.instance_attachment_config.vpc_name
  vswitch_id    = var.instance_attachment_config.vswitch_id
}

# OTS table (optional creation)
resource "alicloud_ots_table" "table" {
  count                         = var.create_table ? 1 : 0
  instance_name                 = local.this_ots_instance_id
  table_name                    = var.table_config.table_name
  time_to_live                  = var.table_config.time_to_live
  max_version                   = var.table_config.max_version
  allow_update                  = var.table_config.allow_update
  deviation_cell_version_in_sec = var.table_config.deviation_cell_version_in_sec
  enable_sse                    = var.table_config.enable_sse
  sse_key_type                  = var.table_config.sse_key_type
  sse_key_id                    = var.table_config.sse_key_id
  sse_role_arn                  = var.table_config.sse_role_arn

  dynamic "primary_key" {
    for_each = var.table_config.primary_keys
    content {
      name = primary_key.value["name"]
      type = primary_key.value["type"]
    }
  }

  dynamic "defined_column" {
    for_each = var.table_config.defined_columns
    content {
      name = defined_column.value["name"]
      type = defined_column.value["type"]
    }
  }
}

# OTS search index (optional creation)
resource "alicloud_ots_search_index" "search_index" {
  count         = var.create_search_index ? 1 : 0
  instance_name = local.this_ots_instance_id
  table_name    = var.create_table ? alicloud_ots_table.table[0].table_name : split(":", var.table_id)[1]
  index_name    = var.search_index_config.index_name
  time_to_live  = var.search_index_config.time_to_live

  schema {
    dynamic "field_schema" {
      for_each = var.search_index_config.field_schemas
      content {
        field_name          = field_schema.value["field_name"]
        field_type          = field_schema.value["field_type"]
        is_array            = field_schema.value["is_array"]
        index               = field_schema.value["index"]
        analyzer            = field_schema.value["analyzer"]
        enable_sort_and_agg = field_schema.value["enable_sort_and_agg"]
        store               = field_schema.value["store"]
      }
    }

    dynamic "index_setting" {
      for_each = var.search_index_config.index_setting != null ? [var.search_index_config.index_setting] : []
      content {
        routing_fields = index_setting.value["routing_fields"]
      }
    }

    dynamic "index_sort" {
      for_each = var.search_index_config.index_sort != null ? [var.search_index_config.index_sort] : []
      content {
        dynamic "sorter" {
          for_each = index_sort.value["sorters"]
          content {
            sorter_type = sorter.value["sorter_type"]
            order       = sorter.value["order"]
            field_name  = sorter.value["field_name"]
            mode        = sorter.value["mode"]
          }
        }
      }
    }
  }
}

# OTS secondary index (optional creation)
resource "alicloud_ots_secondary_index" "secondary_index" {
  count             = var.create_secondary_index ? 1 : 0
  instance_name     = local.this_ots_instance_id
  table_name        = var.create_table ? alicloud_ots_table.table[0].table_name : split(":", var.table_id)[1]
  index_name        = var.secondary_index_config.index_name
  index_type        = var.secondary_index_config.index_type
  include_base_data = var.secondary_index_config.include_base_data
  primary_keys      = var.secondary_index_config.primary_keys
  defined_columns   = var.secondary_index_config.defined_columns
}

# OTS tunnel (optional creation)
resource "alicloud_ots_tunnel" "tunnel" {
  count         = var.create_tunnel ? 1 : 0
  instance_name = local.this_ots_instance_id
  table_name    = var.create_table ? alicloud_ots_table.table[0].table_name : split(":", var.table_id)[1]
  tunnel_name   = var.tunnel_config.tunnel_name
  tunnel_type   = var.tunnel_config.tunnel_type
}