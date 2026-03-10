# Complete Example

This example demonstrates the complete usage of the OTS Terraform module, including creating an OTS instance, table, and optional advanced features like search index, secondary index, and tunnel.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.172.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.172.0 |

## Features Demonstrated

This example shows how to:

1. **Basic OTS Setup**: Create an OTS instance and table with primary keys and defined columns
2. **VPC Attachment** (optional): Attach the OTS instance to a VPC for network isolation
3. **Search Index** (optional): Create a search index for full-text search capabilities
4. **Secondary Index** (optional): Create a secondary index for alternative query patterns
5. **Tunnel** (optional): Create a tunnel for data synchronization

## Configuration Options

The example provides several boolean variables to control which resources are created:

- `create_instance`: Whether to create the OTS instance (default: `true`)
- `create_table`: Whether to create the OTS table (default: `true`)
- `create_vpc`: Whether to create VPC and VSwitch for attachment (default: `false`)
- `create_instance_attachment`: Whether to attach the instance to VPC (default: `false`)
- `create_search_index`: Whether to create search index (default: `false`)
- `create_secondary_index`: Whether to create secondary index (default: `false`)
- `create_tunnel`: Whether to create tunnel (default: `false`)

## Basic Usage

For a minimal setup with just instance and table:

```bash
terraform apply -var="create_instance=true" -var="create_table=true"
```

## Advanced Usage

To enable all features including VPC attachment and indexes:

```bash
terraform apply \
  -var="create_instance=true" \
  -var="create_table=true" \
  -var="create_vpc=true" \
  -var="create_instance_attachment=true" \
  -var="create_search_index=true" \
  -var="create_secondary_index=true" \
  -var="create_tunnel=true"
```

## Outputs

The example outputs all important resource IDs and information from the module, making it easy to reference these resources in other configurations.