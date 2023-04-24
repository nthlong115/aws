resource "aws_eks_cluster" "cluster" {
  name     = var.me_name
  role_arn = aws_iam_role.policy.arn
  version  = var.me_version
  enabled_cluster_log_types = [ "api","audit","authenticator","controllerManager","scheduler" ]

  vpc_config {
    subnet_ids = var.sub_eks
  }

  depends_on = [
    aws_iam_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_policy_attachment.AmazonEKSVPCResourceController
  ]
  tags = {
    Name = "${var.me_name}"
  }
}

resource "aws_iam_role" "policy" {
  name        = "eks_policy"
  path        = "/"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }
  POLICY
  tags = {
    Name = "Eks-Policy"
  }
}

resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles = [aws_iam_role.policy.name]
  name = "at1"
}
resource "aws_iam_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  roles = [aws_iam_role.policy.name]
  name = "at2"
}
#add-on
resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = var.kube_name
  addon_version     = var.kube_version
  resolve_conflicts = "PRESERVE"
}
resource "aws_eks_addon" "core_DNS" {
  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = var.core_name
  addon_version     = var.core_version
  resolve_conflicts = "PRESERVE"
}
resource "aws_eks_addon" "vpc_CNI" {
  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = var.cni_name
  addon_version     = var.cni_version
  resolve_conflicts = "PRESERVE"
}
#node group
resource "aws_iam_role" "node_policy" {
  name = "eks-node-group-example"
  path = "/"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }
  POLICY
  tags = {
    Name = "Policy-for-node-group"
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_policy.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_policy.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_policy.name
}
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node-group"
  node_role_arn   = aws_iam_role.node_policy.arn
  subnet_ids      = var.sub_eks
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}