output "instance_id" {
  description = "The ID of the OTS instance"
  value       = module.ots.instance_id
}

output "instance_name" {
  description = "The name of the OTS instance"
  value       = module.ots.instance_name
}

output "table_id" {
  description = "The ID of the OTS table"
  value       = module.ots.table_id
}

output "table_name" {
  description = "The name of the OTS table"
  value       = module.ots.table_name
}

output "search_index_id" {
  description = "The ID of the OTS search index"
  value       = module.ots.search_index_id
}

output "secondary_index_id" {
  description = "The ID of the OTS secondary index"
  value       = module.ots.secondary_index_id
}

output "tunnel_id" {
  description = "The ID of the OTS tunnel"
  value       = module.ots.tunnel_id
}

output "this_instance_id" {
  description = "The ID of the OTS instance (created by this module or provided externally)"
  value       = module.ots.this_instance_id
}

output "this_table_id" {
  description = "The ID of the OTS table (created by this module or provided externally)"
  value       = module.ots.this_table_id
}