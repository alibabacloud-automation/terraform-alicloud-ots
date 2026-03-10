Terraform Module for Alibaba Cloud OTS (Table Store) Service

# terraform-alicloud-ots

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ots/blob/main/README-CN.md)

This Terraform module provides a comprehensive solution for managing Alibaba Cloud OTS (Table Store) resources, including instances, tables, search indexes, secondary indexes, tunnels, and VPC attachments. OTS is a fully managed NoSQL database service that provides fast access to massive amounts of structured data. This module helps you set up [Table Store services](https://www.alibabacloud.com/help/en/tablestore/) with best practices and flexible configuration options.

## Usage

This module allows you to create and manage OTS resources with fine-grained control over each component. You can choose to create new resources or use existing ones, making it suitable for various deployment scenarios.

```terraform
module "ots" {
  source = "alibabacloud-automation/ots/alicloud"

  # Create OTS instance and table
  create_instance = true
  create_table    = true

  # OTS instance configuration
  instance_config = {
    name               = "my-ots-instance"
    description        = "OTS instance for my application"
    accessed_by        = "Any"
    instance_type      = "HighPerformance"
    network_type_acl   = ["VPC", "CLASSIC", "INTERNET"]
    network_source_acl = ["TRUST_PROXY"]
    tags = {
      Environment = "production"
      Project     = "my-project"
    }
  }

  # OTS table configuration
  table_config = {
    table_name   = "my-table"
    time_to_live = -1
    max_version  = 1
    primary_keys = [
      {
        name = "pk1"
        type = "Integer"
      },
      {
        name = "pk2"
        type = "String"
      }
    ]
    defined_columns = [
      {
        name = "col1"
        type = "String"
      },
      {
        name = "col2"
        type = "Integer"
      }
    ]
    enable_sse   = true
    sse_key_type = "SSE_KMS_SERVICE"
  }

  # Optionally create search index
  create_search_index = true
  search_index_config = {
    index_name = "my-search-index"
    field_schemas = [
      {
        field_name = "col1"
        field_type = "Text"
        index      = true
        store      = true
      },
      {
        field_name          = "col2"
        field_type          = "Long"
        enable_sort_and_agg = true
      }
    ]
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ots/tree/main/examples/complete) - Demonstrates all features including instance, table, search index, secondary index, and tunnel creation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.172.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.172.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ots_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_instance) | resource |
| [alicloud_ots_instance_attachment.attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_instance_attachment) | resource |
| [alicloud_ots_search_index.search_index](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_search_index) | resource |
| [alicloud_ots_secondary_index.secondary_index](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_secondary_index) | resource |
| [alicloud_ots_table.table](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_table) | resource |
| [alicloud_ots_tunnel.tunnel](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_tunnel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | Whether to create a new OTS instance. If false, an existing instance ID must be provided. | `bool` | `true` | no |
| <a name="input_create_instance_attachment"></a> [create\_instance\_attachment](#input\_create\_instance\_attachment) | Whether to create OTS instance VPC attachment. | `bool` | `false` | no |
| <a name="input_create_search_index"></a> [create\_search\_index](#input\_create\_search\_index) | Whether to create a search index for the OTS table. | `bool` | `false` | no |
| <a name="input_create_secondary_index"></a> [create\_secondary\_index](#input\_create\_secondary\_index) | Whether to create a secondary index for the OTS table. | `bool` | `false` | no |
| <a name="input_create_table"></a> [create\_table](#input\_create\_table) | Whether to create a table in the OTS instance. | `bool` | `false` | no |
| <a name="input_create_tunnel"></a> [create\_tunnel](#input\_create\_tunnel) | Whether to create a tunnel for the OTS table. | `bool` | `false` | no |
| <a name="input_instance_attachment_config"></a> [instance\_attachment\_config](#input\_instance\_attachment\_config) | The parameters of OTS instance VPC attachment. The attributes 'vpc\_name' and 'vswitch\_id' are required. | <pre>object({<br>    vpc_name   = string<br>    vswitch_id = string<br>  })</pre> | <pre>{<br>  "vpc_name": null,<br>  "vswitch_id": null<br>}</pre> | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | The parameters of OTS instance. The attribute 'name' is required. | <pre>object({<br>    name               = string<br>    description        = optional(string, null)<br>    accessed_by        = optional(string, "Any")<br>    instance_type      = optional(string, "HighPerformance")<br>    network_type_acl   = optional(list(string), ["VPC", "CLASSIC", "INTERNET"])<br>    network_source_acl = optional(list(string), ["TRUST_PROXY"])<br>    resource_group_id  = optional(string, null)<br>    tags               = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "name": null<br>}</pre> | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | The ID of an existing OTS instance. Required when create\_instance is false. | `string` | `null` | no |
| <a name="input_search_index_config"></a> [search\_index\_config](#input\_search\_index\_config) | The parameters of OTS search index. The attributes 'index\_name' and 'field\_schemas' are required. | <pre>object({<br>    index_name   = string<br>    time_to_live = optional(number, -1)<br>    field_schemas = list(object({<br>      field_name          = string<br>      field_type          = string<br>      is_array            = optional(bool, false)<br>      index               = optional(bool, true)<br>      analyzer            = optional(string, null)<br>      enable_sort_and_agg = optional(bool, false)<br>      store               = optional(bool, false)<br>    }))<br>    index_setting = optional(object({<br>      routing_fields = optional(list(string), [])<br>    }), null)<br>    index_sort = optional(object({<br>      sorters = list(object({<br>        sorter_type = optional(string, "PrimaryKeySort")<br>        order       = optional(string, "Asc")<br>        field_name  = optional(string, null)<br>        mode        = optional(string, null)<br>      }))<br>    }), null)<br>  })</pre> | <pre>{<br>  "field_schemas": [],<br>  "index_name": null<br>}</pre> | no |
| <a name="input_secondary_index_config"></a> [secondary\_index\_config](#input\_secondary\_index\_config) | The parameters of OTS secondary index. The attributes 'index\_name', 'index\_type', 'include\_base\_data' and 'primary\_keys' are required. | <pre>object({<br>    index_name        = string<br>    index_type        = string<br>    include_base_data = bool<br>    primary_keys      = list(string)<br>    defined_columns   = optional(list(string), [])<br>  })</pre> | <pre>{<br>  "include_base_data": null,<br>  "index_name": null,<br>  "index_type": null,<br>  "primary_keys": []<br>}</pre> | no |
| <a name="input_table_config"></a> [table\_config](#input\_table\_config) | The parameters of OTS table. The attributes 'table\_name', 'time\_to\_live', 'max\_version' and 'primary\_keys' are required. | <pre>object({<br>    table_name                    = string<br>    time_to_live                  = number<br>    max_version                   = number<br>    allow_update                  = optional(bool, true)<br>    deviation_cell_version_in_sec = optional(number, 86400)<br>    enable_sse                    = optional(bool, false)<br>    sse_key_type                  = optional(string, null)<br>    sse_key_id                    = optional(string, null)<br>    sse_role_arn                  = optional(string, null)<br>    primary_keys = list(object({<br>      name = string<br>      type = string<br>    }))<br>    defined_columns = optional(list(object({<br>      name = string<br>      type = string<br>    })), [])<br>  })</pre> | <pre>{<br>  "max_version": null,<br>  "primary_keys": [],<br>  "table_name": null,<br>  "time_to_live": null<br>}</pre> | no |
| <a name="input_table_id"></a> [table\_id](#input\_table\_id) | The ID of an existing OTS table. Required when create\_table is false. | `string` | `null` | no |
| <a name="input_tunnel_config"></a> [tunnel\_config](#input\_tunnel\_config) | The parameters of OTS tunnel. The attributes 'tunnel\_name' and 'tunnel\_type' are required. | <pre>object({<br>    tunnel_name = string<br>    tunnel_type = string<br>  })</pre> | <pre>{<br>  "tunnel_name": null,<br>  "tunnel_type": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_attachment_id"></a> [instance\_attachment\_id](#output\_instance\_attachment\_id) | The ID of the OTS instance VPC attachment |
| <a name="output_instance_attachment_vpc_id"></a> [instance\_attachment\_vpc\_id](#output\_instance\_attachment\_vpc\_id) | The VPC ID of the OTS instance attachment |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the OTS instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The name of the OTS instance |
| <a name="output_search_index_create_time"></a> [search\_index\_create\_time](#output\_search\_index\_create\_time) | The create time of the OTS search index |
| <a name="output_search_index_current_sync_timestamp"></a> [search\_index\_current\_sync\_timestamp](#output\_search\_index\_current\_sync\_timestamp) | The current sync timestamp of the OTS search index |
| <a name="output_search_index_id"></a> [search\_index\_id](#output\_search\_index\_id) | The ID of the OTS search index |
| <a name="output_search_index_name"></a> [search\_index\_name](#output\_search\_index\_name) | The name of the OTS search index |
| <a name="output_search_index_sync_phase"></a> [search\_index\_sync\_phase](#output\_search\_index\_sync\_phase) | The sync phase of the OTS search index |
| <a name="output_secondary_index_id"></a> [secondary\_index\_id](#output\_secondary\_index\_id) | The ID of the OTS secondary index |
| <a name="output_secondary_index_name"></a> [secondary\_index\_name](#output\_secondary\_index\_name) | The name of the OTS secondary index |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | The ID of the OTS table |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | The name of the OTS table |
| <a name="output_this_instance_id"></a> [this\_instance\_id](#output\_this\_instance\_id) | The ID of the OTS instance (created by this module or provided externally) |
| <a name="output_this_table_id"></a> [this\_table\_id](#output\_this\_table\_id) | The ID of the OTS table (created by this module or provided externally) |
| <a name="output_tunnel_channels"></a> [tunnel\_channels](#output\_tunnel\_channels) | The channels of the OTS tunnel |
| <a name="output_tunnel_create_time"></a> [tunnel\_create\_time](#output\_tunnel\_create\_time) | The create time of the OTS tunnel |
| <a name="output_tunnel_expired"></a> [tunnel\_expired](#output\_tunnel\_expired) | Whether the OTS tunnel has expired |
| <a name="output_tunnel_id"></a> [tunnel\_id](#output\_tunnel\_id) | The ID of the OTS tunnel |
| <a name="output_tunnel_name"></a> [tunnel\_name](#output\_tunnel\_name) | The name of the OTS tunnel |
| <a name="output_tunnel_rpo"></a> [tunnel\_rpo](#output\_tunnel\_rpo) | The RPO of the OTS tunnel |
| <a name="output_tunnel_stage"></a> [tunnel\_stage](#output\_tunnel\_stage) | The stage of the OTS tunnel |
| <a name="output_tunnel_tunnel_id"></a> [tunnel\_tunnel\_id](#output\_tunnel\_tunnel\_id) | The tunnel ID of the OTS tunnel |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)