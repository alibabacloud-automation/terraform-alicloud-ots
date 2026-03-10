provider "alicloud" {
  region = var.region
}

# Get available zones
data "alicloud_zones" "available" {
  available_resource_creation = "VSwitch"
}

# Create VPC for OTS instance attachment (if needed)
resource "alicloud_vpc" "example" {
  count      = var.create_vpc ? 1 : 0
  vpc_name   = "ots-example-vpc"
  cidr_block = "10.0.0.0/16"
}

# Create VSwitch for OTS instance attachment (if needed)
resource "alicloud_vswitch" "example" {
  count        = var.create_vpc ? 1 : 0
  vpc_id       = alicloud_vpc.example[0].id
  cidr_block   = "10.0.1.0/24"
  zone_id      = data.alicloud_zones.available.zones[0].id
  vswitch_name = "ots-example-vswitch"
}

# Use the OTS module
module "ots" {
  source = "../../"

  # Control which resources to create
  create_instance            = var.create_instance
  create_instance_attachment = var.create_instance_attachment && var.create_vpc
  create_table               = var.create_table
  create_search_index        = var.create_search_index
  create_secondary_index     = var.create_secondary_index
  create_tunnel              = var.create_tunnel

  # OTS instance configuration
  instance_config = {
    name          = var.instance_name
    description   = "OTS instance created by Terraform example"
    accessed_by   = "Any"
    instance_type = "HighPerformance"
    tags = {
      Environment = "test"
      CreatedBy   = "terraform"
    }
  }

  # OTS instance VPC attachment configuration
  instance_attachment_config = {
    vpc_name   = var.create_instance_attachment && var.create_vpc ? "example-vpc" : null
    vswitch_id = var.create_instance_attachment && var.create_vpc ? alicloud_vswitch.example[0].id : null
  }

  # OTS table configuration
  table_config = {
    table_name   = var.table_name
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

  # OTS search index configuration
  search_index_config = {
    index_name = "example_search_index"
    field_schemas = [
      {
        field_name = "col1"
        field_type = "Text"
        index      = true
        analyzer   = "Split"
        store      = true
      },
      {
        field_name          = "col2"
        field_type          = "Long"
        enable_sort_and_agg = true
      },
      {
        field_name = "pk1"
        field_type = "Long"
      },
      {
        field_name = "pk2"
        field_type = "Text"
      }
    ]
    index_setting = {
      routing_fields = ["pk1", "pk2"]
    }
    index_sort = {
      sorters = [
        {
          sorter_type = "PrimaryKeySort"
          order       = "Asc"
        },
        {
          sorter_type = "FieldSort"
          order       = "Desc"
          field_name  = "col2"
          mode        = "Max"
        }
      ]
    }
  }

  # OTS secondary index configuration
  secondary_index_config = {
    index_name        = "example_secondary_index"
    index_type        = "Global"
    include_base_data = true
    primary_keys      = ["pk1", "pk2"]
    defined_columns   = ["col1", "col2"]
  }

  # OTS tunnel configuration
  tunnel_config = {
    tunnel_name = "example_tunnel"
    tunnel_type = "BaseAndStream"
  }
}