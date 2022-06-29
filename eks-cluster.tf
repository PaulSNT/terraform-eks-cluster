module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.23.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnets
  cluster_ip_family               = "ipv4"
  cluster_security_group_name     = "${local.cluster_name}-cluster-sg"
  node_security_group_name        = "${local.cluster_name}-node-sg"
  cluster_endpoint_private_access = true
  
  eks_managed_node_groups = [
    {
      name                          = "${local.cluster_name}-ng"
      capacity_type		    = "SPOT"
      instance_types                = ["t2.small"]
      key_name			    = "PSS-Imported-Key"
      create_launch_template        = "true"
      launch_template_name          = "${local.cluster_name}-launch-template"
      max_size                      = 3
      min_size			    = 1
      desired_size                  = 3
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
