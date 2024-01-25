output "engiam_namespace" {
  description = "new namespace created"
  value       = kubectl_manifest.engiam_namespace
  sensitive   = true
}

output "engiam_service_account" {
  description = "service account created for namespace"
  value       = kubectl_manifest.engiam_service_account
  sensitive   = true
}

output "engiam_service_account_cluster_role_binding_crossplane_managed_resources" {
  description = "cluster role bound to service account to view crossplane managed resources"
  value       = kubectl_manifest.engiam_service_account_cluster_role_binding_crossplane_managed_resources
  sensitive   = true
}

output "engiam_service_account_role_binding_namespace_resources" {
  description = "role bound to service account with full access to namespace resources"
  value       = kubectl_manifest.engiam_service_account_role_binding_namespace_resources
  sensitive   = true
}