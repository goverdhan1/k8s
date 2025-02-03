resource "aws_eks_cluster" "main" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]

  # Add lifecycle block to prevent recreation
  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      vpc_config,
      version,
      encryption_config
    ]
  }
}