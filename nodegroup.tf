# eks-nodegroup.tf
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = aws_subnet.public[*].id

  ami_type        = "CUSTOM"  # Use "CUSTOM" when specifying a custom AMI
  # release_version = var.ami_id  # Use Ubuntu AMI ID

  scaling_config {
    desired_size = 8
    max_size     = 30
    min_size     = 1
  }

  # Use larger instance type for more resources
  # instance_types = ["t2.medium"]

  # Add labels for better identification
  labels = {
    "role" = "general"
    "type" = "worker"
  }

  #  remote_access {
  #   ec2_ssh_key               = "Mediator"
  #   source_security_group_ids = [aws_security_group.node_group_sg.id]
  # }

  # Configure launch template with more disk space
  launch_template {
    name    = aws_launch_template.eks_nodes.name
    version = aws_launch_template.eks_nodes.latest_version
  }

   timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group_AmazonEC2ContainerRegistryReadOnly,
    aws_security_group.node_group_sg
  ]

  tags = {
    Name = "${var.cluster_name}-node-group"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}