locals {
  namespace                   = var.namespace
  service_account             = "read-pods-sa"
  cluster_role_ref            = "system:aggregate-to-view"
  crossplane_role_ref         = "crossplane-view"
  crossplane_managed_role_ref = "eng-iam-hsdp:managed-crossplane-resources:view"
}