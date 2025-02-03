# locals.tf
locals {
  # Cluster role ARN
  cluster_role_arn = aws_iam_role.eks_cluster_role.arn

  # Node role ARN
  node_role_arn = aws_iam_role.eks_node_role.arn

  # Security group IDs
  cluster_sg_id = var.use_existing_security_groups ? (
    var.existing_cluster_sg_id
  ) : (
    aws_security_group.eks_cluster_sg[0].id
  )

  # ALB security group ID
  alb_sg_id = var.use_existing_security_groups ? (
    var.existing_cluster_sg_id
  ) : (
    aws_security_group.alb_sg[0].id
  )
}
