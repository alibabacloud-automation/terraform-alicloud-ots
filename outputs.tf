# OTS instance outputs
output "instance_id" {
  description = "The ID of the OTS instance"
  value       = var.create_instance ? alicloud_ots_instance.instance[0].id : null
}

output "instance_name" {
  description = "The name of the OTS instance"
  value       = var.create_instance ? alicloud_ots_instance.instance[0].name : null
}

# OTS instance VPC attachment outputs
output "instance_attachment_id" {
  description = "The ID of the OTS instance VPC attachment"
  value       = var.create_instance_attachment ? alicloud_ots_instance_attachment.attachment[0].id : null
}

output "instance_attachment_vpc_id" {
  description = "The VPC ID of the OTS instance attachment"
  value       = var.create_instance_attachment ? alicloud_ots_instance_attachment.attachment[0].vpc_id : null
}

# OTS table outputs
output "table_id" {
  description = "The ID of the OTS table"
  value       = var.create_table ? alicloud_ots_table.table[0].id : null
}

output "table_name" {
  description = "The name of the OTS table"
  value       = var.create_table ? alicloud_ots_table.table[0].table_name : null
}

# OTS search index outputs
output "search_index_id" {
  description = "The ID of the OTS search index"
  value       = var.create_search_index ? alicloud_ots_search_index.search_index[0].index_id : null
}

output "search_index_name" {
  description = "The name of the OTS search index"
  value       = var.create_search_index ? alicloud_ots_search_index.search_index[0].index_name : null
}

output "search_index_create_time" {
  description = "The create time of the OTS search index"
  value       = var.create_search_index ? alicloud_ots_search_index.search_index[0].create_time : null
}

output "search_index_sync_phase" {
  description = "The sync phase of the OTS search index"
  value       = var.create_search_index ? alicloud_ots_search_index.search_index[0].sync_phase : null
}

output "search_index_current_sync_timestamp" {
  description = "The current sync timestamp of the OTS search index"
  value       = var.create_search_index ? alicloud_ots_search_index.search_index[0].current_sync_timestamp : null
}

# OTS secondary index outputs
output "secondary_index_id" {
  description = "The ID of the OTS secondary index"
  value       = var.create_secondary_index ? alicloud_ots_secondary_index.secondary_index[0].id : null
}

output "secondary_index_name" {
  description = "The name of the OTS secondary index"
  value       = var.create_secondary_index ? alicloud_ots_secondary_index.secondary_index[0].index_name : null
}

# OTS tunnel outputs
output "tunnel_id" {
  description = "The ID of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].id : null
}

output "tunnel_name" {
  description = "The name of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].tunnel_name : null
}

output "tunnel_tunnel_id" {
  description = "The tunnel ID of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].tunnel_id : null
}

output "tunnel_rpo" {
  description = "The RPO of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].tunnel_rpo : null
}

output "tunnel_stage" {
  description = "The stage of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].tunnel_stage : null
}

output "tunnel_expired" {
  description = "Whether the OTS tunnel has expired"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].expired : null
}

output "tunnel_create_time" {
  description = "The create time of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].create_time : null
}

output "tunnel_channels" {
  description = "The channels of the OTS tunnel"
  value       = var.create_tunnel ? alicloud_ots_tunnel.tunnel[0].channels : null
}

# Consolidated outputs for easy reference
output "this_instance_id" {
  description = "The ID of the OTS instance (created by this module or provided externally)"
  value       = local.this_ots_instance_id
}

output "this_table_id" {
  description = "The ID of the OTS table (created by this module or provided externally)"
  value       = local.this_ots_table_id
}