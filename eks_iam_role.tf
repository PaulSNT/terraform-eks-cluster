module "eks_iam_role" {
  source = "cloudposse/eks-iam-role/aws"

//  eks_cluster_oidc_issuer_url = module.eks.aws_iam_openid_connect_provider.oidc_provider[0]
  eks_cluster_oidc_issuer_url = "https://oidc.eks.eu-west-3.amazonaws.com/id/B88AB81553DF5DE3AF0A47AE87B178F6" 

  service_account_name      = "aws-load-balancer-controller"
  service_account_namespace = "kube-system"

  aws_iam_policy_document = "${file("./iam_policy.json")}"
}


