locals {
  eks_cluster_name     = var.cluster_name
  eks_environement     = trimsuffix(local.eks_cluster_name, "-cluster")
  db_subnet_group_name = "${local.eks_environement}-vpc-db-subnet-group"
  rds_kms_alias_name   = "alias/aws/rds"
}
