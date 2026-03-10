阿里云表格存储（OTS）服务 Terraform 模块

# terraform-alicloud-ots

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ots/blob/main/README.md) | 简体中文

此 Terraform 模块为管理阿里云表格存储（OTS）资源提供了全面的解决方案，包括实例、表、搜索索引、二级索引、数据通道和 VPC 绑定。OTS 是一个完全托管的 NoSQL 数据库服务，可快速访问海量结构化数据。此模块帮助您使用最佳实践和灵活的配置选项设置[表格存储服务](https://www.alibabacloud.com/help/en/tablestore/)。

## 使用方法

此模块允许您创建和管理 OTS 资源，并对每个组件进行细粒度控制。您可以选择创建新资源或使用现有资源，使其适用于各种部署场景。

```terraform
module "ots" {
  source = "alibabacloud-automation/ots/alicloud"

  # 创建 OTS 实例和表
  create_instance = true
  create_table    = true

  # OTS 实例配置
  instance_config = {
    name               = "my-ots-instance"
    description        = "我的应用程序的 OTS 实例"
    accessed_by        = "Any"
    instance_type      = "HighPerformance"
    network_type_acl   = ["VPC", "CLASSIC", "INTERNET"]
    network_source_acl = ["TRUST_PROXY"]
    tags = {
      Environment = "production"
      Project     = "my-project"
    }
  }

  # OTS 表配置
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

  # 可选创建搜索索引
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

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ots/tree/main/examples/complete) - 演示所有功能，包括实例、表、搜索索引、二级索引和数据通道创建

<!-- BEGIN_TF_DOCS -->
## 需求

| 名称 | 版本 |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.172.0 |

## Providers

| 名称 | 版本 |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.172.0 |

## Modules

无模块。

## 资源

| 名称 | 类型 |
|------|------|
| [alicloud_ots_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_instance) | resource |
| [alicloud_ots_instance_attachment.attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_instance_attachment) | resource |
| [alicloud_ots_search_index.search_index](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_search_index) | resource |
| [alicloud_ots_secondary_index.secondary_index](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_secondary_index) | resource |
| [alicloud_ots_table.table](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_table) | resource |
| [alicloud_ots_tunnel.tunnel](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_tunnel) | resource |

## 输入

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | 是否创建新的 OTS 实例。如果为 false，则必须提供现有实例 ID。 | `bool` | `true` | no |
| <a name="input_create_instance_attachment"></a> [create\_instance\_attachment](#input\_create\_instance\_attachment) | 是否创建 OTS 实例 VPC 绑定。 | `bool` | `false` | no |
| <a name="input_create_search_index"></a> [create\_search\_index](#input\_create\_search\_index) | 是否为 OTS 表创建搜索索引。 | `bool` | `false` | no |
| <a name="input_create_secondary_index"></a> [create\_secondary\_index](#input\_create\_secondary\_index) | 是否为 OTS 表创建二级索引。 | `bool` | `false` | no |
| <a name="input_create_table"></a> [create\_table](#input\_create\_table) | 是否在 OTS 实例中创建表。 | `bool` | `false` | no |
| <a name="input_create_tunnel"></a> [create\_tunnel](#input\_create\_tunnel) | 是否为 OTS 表创建数据通道。 | `bool` | `false` | no |
| <a name="input_instance_attachment_config"></a> [instance\_attachment\_config](#input\_instance\_attachment\_config) | OTS 实例 VPC 绑定的参数。属性 'vpc\_name' 和 'vswitch\_id' 是必需的。 | <pre>object({<br>    vpc_name   = string<br>    vswitch_id = string<br>  })</pre> | <pre>{<br>  "vpc_name": null,<br>  "vswitch_id": null<br>}</pre> | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | OTS 实例的参数。属性 'name' 是必需的。 | <pre>object({<br>    name               = string<br>    description        = optional(string, null)<br>    accessed_by        = optional(string, "Any")<br>    instance_type      = optional(string, "HighPerformance")<br>    network_type_acl   = optional(list(string), ["VPC", "CLASSIC", "INTERNET"])<br>    network_source_acl = optional(list(string), ["TRUST_PROXY"])<br>    resource_group_id  = optional(string, null)<br>    tags               = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "name": null<br>}</pre> | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | 现有 OTS 实例的 ID。当 create\_instance 为 false 时必需。 | `string` | `null` | no |
| <a name="input_search_index_config"></a> [search\_index\_config](#input\_search\_index\_config) | OTS 搜索索引的参数。属性 'index\_name' 和 'field\_schemas' 是必需的。 | <pre>object({<br>    index_name   = string<br>    time_to_live = optional(number, -1)<br>    field_schemas = list(object({<br>      field_name          = string<br>      field_type          = string<br>      is_array            = optional(bool, false)<br>      index               = optional(bool, true)<br>      analyzer            = optional(string, null)<br>      enable_sort_and_agg = optional(bool, false)<br>      store               = optional(bool, false)<br>    }))<br>    index_setting = optional(object({<br>      routing_fields = optional(list(string), [])<br>    }), null)<br>    index_sort = optional(object({<br>      sorters = list(object({<br>        sorter_type = optional(string, "PrimaryKeySort")<br>        order       = optional(string, "Asc")<br>        field_name  = optional(string, null)<br>        mode        = optional(string, null)<br>      }))<br>    }), null)<br>  })</pre> | <pre>{<br>  "field_schemas": [],<br>  "index_name": null<br>}</pre> | no |
| <a name="input_secondary_index_config"></a> [secondary\_index\_config](#input\_secondary\_index\_config) | OTS 二级索引的参数。属性 'index\_name'、'index\_type'、'include\_base\_data' 和 'primary\_keys' 是必需的。 | <pre>object({<br>    index_name        = string<br>    index_type        = string<br>    include_base_data = bool<br>    primary_keys      = list(string)<br>    defined_columns   = optional(list(string), [])<br>  })</pre> | <pre>{<br>  "include_base_data": null,<br>  "index_name": null,<br>  "index_type": null,<br>  "primary_keys": []<br>}</pre> | no |
| <a name="input_table_config"></a> [table\_config](#input\_table\_config) | OTS 表的参数。属性 'table\_name'、'time\_to\_live'、'max\_version' 和 'primary\_keys' 是必需的。 | <pre>object({<br>    table_name                    = string<br>    time_to_live                  = number<br>    max_version                   = number<br>    allow_update                  = optional(bool, true)<br>    deviation_cell_version_in_sec = optional(number, 86400)<br>    enable_sse                    = optional(bool, false)<br>    sse_key_type                  = optional(string, null)<br>    sse_key_id                    = optional(string, null)<br>    sse_role_arn                  = optional(string, null)<br>    primary_keys = list(object({<br>      name = string<br>      type = string<br>    }))<br>    defined_columns = optional(list(object({<br>      name = string<br>      type = string<br>    })), [])<br>  })</pre> | <pre>{<br>  "max_version": null,<br>  "primary_keys": [],<br>  "table_name": null,<br>  "time_to_live": null<br>}</pre> | no |
| <a name="input_table_id"></a> [table\_id](#input\_table\_id) | 现有 OTS 表的 ID。当 create\_table 为 false 时必需。 | `string` | `null` | no |
| <a name="input_tunnel_config"></a> [tunnel\_config](#input\_tunnel\_config) | OTS 数据通道的参数。属性 'tunnel\_name' 和 'tunnel\_type' 是必需的。 | <pre>object({<br>    tunnel_name = string<br>    tunnel_type = string<br>  })</pre> | <pre>{<br>  "tunnel_name": null,<br>  "tunnel_type": null<br>}</pre> | no |

## 输出

| 名称 | 描述 |
|------|-------------|
| <a name="output_instance_attachment_id"></a> [instance\_attachment\_id](#output\_instance\_attachment\_id) | OTS 实例 VPC 绑定的 ID |
| <a name="output_instance_attachment_vpc_id"></a> [instance\_attachment\_vpc\_id](#output\_instance\_attachment\_vpc\_id) | OTS 实例绑定的 VPC ID |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | OTS 实例的 ID |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | OTS 实例的名称 |
| <a name="output_search_index_create_time"></a> [search\_index\_create\_time](#output\_search\_index\_create\_time) | OTS 搜索索引的创建时间 |
| <a name="output_search_index_current_sync_timestamp"></a> [search\_index\_current\_sync\_timestamp](#output\_search\_index\_current\_sync\_timestamp) | OTS 搜索索引的当前同步时间戳 |
| <a name="output_search_index_id"></a> [search\_index\_id](#output\_search\_index\_id) | OTS 搜索索引的 ID |
| <a name="output_search_index_name"></a> [search\_index\_name](#output\_search\_index\_name) | OTS 搜索索引的名称 |
| <a name="output_search_index_sync_phase"></a> [search\_index\_sync\_phase](#output\_search\_index\_sync\_phase) | OTS 搜索索引的同步阶段 |
| <a name="output_secondary_index_id"></a> [secondary\_index\_id](#output\_secondary\_index\_id) | OTS 二级索引的 ID |
| <a name="output_secondary_index_name"></a> [secondary\_index\_name](#output\_secondary\_index\_name) | OTS 二级索引的名称 |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | OTS 表的 ID |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | OTS 表的名称 |
| <a name="output_this_instance_id"></a> [this\_instance\_id](#output\_this\_instance\_id) | OTS 实例的 ID（由此模块创建或外部提供） |
| <a name="output_this_table_id"></a> [this\_table\_id](#output\_this\_table\_id) | OTS 表的 ID（由此模块创建或外部提供） |
| <a name="output_tunnel_channels"></a> [tunnel\_channels](#output\_tunnel\_channels) | OTS 数据通道的通道 |
| <a name="output_tunnel_create_time"></a> [tunnel\_create\_time](#output\_tunnel\_create\_time) | OTS 数据通道的创建时间 |
| <a name="output_tunnel_expired"></a> [tunnel\_expired](#output\_tunnel\_expired) | OTS 数据通道是否已过期 |
| <a name="output_tunnel_id"></a> [tunnel\_id](#output\_tunnel\_id) | OTS 数据通道的 ID |
| <a name="output_tunnel_name"></a> [tunnel\_name](#output\_tunnel\_name) | OTS 数据通道的名称 |
| <a name="output_tunnel_rpo"></a> [tunnel\_rpo](#output\_tunnel\_rpo) | OTS 数据通道的 RPO |
| <a name="output_tunnel_stage"></a> [tunnel\_stage](#output\_tunnel\_stage) | OTS 数据通道的阶段 |
| <a name="output_tunnel_tunnel_id"></a> [tunnel\_tunnel\_id](#output\_tunnel\_tunnel\_id) | OTS 数据通道的通道 ID |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)