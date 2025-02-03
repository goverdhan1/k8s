# resource "aws_launch_template" "eks_nodes" {
#   name_prefix            = "${var.cluster_name}-node-"
#   description           = "EKS node launch template"
#   update_default_version = true

#   vpc_security_group_ids = [aws_security_group.node_group_sg.id]

#   # Updated bootstrap script with more parameters
#   user_data = base64encode(<<-EOF
# MIME-Version: 1.0
# Content-Type: multipart/mixed; boundary="//"

# --//
# Content-Type: text/x-shellscript; charset="us-ascii"

# #!/bin/bash
# set -ex
# B64_CLUSTER_CA=${aws_eks_cluster.main.certificate_authority[0].data}
# API_SERVER_URL=${aws_eks_cluster.main.endpoint}
# /etc/eks/bootstrap.sh ${var.cluster_name} \
#     --b64-cluster-ca $B64_CLUSTER_CA \
#     --apiserver-endpoint $API_SERVER_URL \
#     --dns-cluster-ip 172.20.0.10 \
#     --kubelet-extra-args '--node-labels=eks.amazonaws.com/nodegroup=${var.cluster_name}-node-group' \
#     --container-runtime containerd

# --//--
# EOF
#   )

#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs {
#       volume_size           = var.root_volume_size
#       volume_type          = "gp3"
#       delete_on_termination = true
#     }
#   }

#   monitoring {
#     enabled = true
#   }

#   key_name      = "Mediator" # Add SSH key here
#   network_interfaces {
#     associate_public_ip_address = true
#     security_groups             = [aws_security_group.node_group_sg.id]
#   }

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name        = "${var.cluster_name}-node"
#       Environment = var.environment
#     }
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# data "aws_ami" "latest_ubuntu" {
#   most_recent = true
#   owners      = [var.ami_owner]  # Use owner from variables

#   filter {
#     name   = "name"
#     values = [var.ami_name_pattern]  # Use filter from variables
#   }
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]  # Ensures compatibility with most EC2 instances
#   }
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = [var.ami_virtualization_type]  # Use virtualization type from variables
#   }
# }


resource "aws_launch_template" "eks_nodes" {
  name_prefix            = "${var.cluster_name}-node-"
  description            = "EKS node launch template"
  update_default_version = true

  image_id               = var.ami_id  # Ensure this is an Ubuntu EKS-optimized AMI
  # image_id               = data.aws_ami.latest_ubuntu.id  # Dynamically get latest Ubuntu AMI
  instance_type          = var.instance_type
  # instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.node_group_sg.id]

  user_data = base64encode(<<-EOF
  #!/bin/bash
  set -ex
  /etc/eks/bootstrap.sh ${var.cluster_name}
  EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  key_name = "Mediator"  # Move the SSH key here

  lifecycle {
    create_before_destroy = true
  }
}
