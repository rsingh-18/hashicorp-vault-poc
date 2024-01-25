data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = var.cluster_name
}
data "aws_db_subnet_group" "eng_iam_rds_subnet_group" {
  name  = local.db_subnet_group_name
  count = var.enable_rds_creation ? 1 : 0
}
data "aws_kms_key" "eng_iam_rds_kms_key" {
  key_id = local.rds_kms_alias_name
  count  = var.enable_rds_creation ? 1 : 0
}
data "aws_security_groups" "eng_iam_rds_default_vpc_security_group" {
  tags = {
    Name        = "${local.eks_environement}-default-sg"
    Environment = local.eks_environement
  }
  count = var.enable_rds_creation ? 1 : 0
}

data "aws_security_groups" "eng_iam_rds_cluster_vpc_security_group" {
  filter {
    name   = "group-name"
    values = ["eks-cluster-sg-${local.eks_cluster_name}-*"]
  }
  count = var.enable_rds_creation ? 1 : 0
}