# # kubernetes.tf
# resource "time_sleep" "wait_for_kubernetes" {
#   depends_on = [aws_eks_node_group.main]

#   create_duration = "20s"
# }

# # This resource will create (at least) 30 seconds after null_resource.previous
# resource "null_resource" "next" {
#   depends_on = [time_sleep.wait_for_kubernetes]
# }

# # Create a null_resource to verify cluster connectivity
# resource "null_resource" "verify_cluster_connectivity" {
#   depends_on = [aws_eks_cluster.main, aws_eks_node_group.main]

#   provisioner "local-exec" {
#     command = <<-EOT
#       for i in {1..6}; do
#         if aws eks describe-cluster --name ${aws_eks_cluster.main.name} --query 'cluster.status' --output text | grep -q ACTIVE; then
#           echo "Cluster is active and ready!"
#           exit 0
#         fi
#         echo "Waiting for cluster to be ready..."
#         sleep 30
#       done
#       echo "Timeout waiting for cluster to be ready"
#       exit 1
#     EOT
#   }
# }
