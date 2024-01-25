provider "aws" {
  # Configuration options
  profile = var.profile
  region  = var.region
}

provider "kubectl" {
  load_config_file       = false
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
  apply_retry_count = 5
}