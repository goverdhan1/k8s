resource "kubernetes_deployment" "nestjs-docker" {
  metadata {
    name = "nestjs-docker"
    labels = {
      app = "nestjs-docker"
    }
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = {
        app = "nestjs-docker"
      }
    }

    template {
      metadata {
        labels = {
          app = "nestjs-docker"
        }
      }

      spec {
        image_pull_secrets {
          name = "ghcr-secret"
        }

        container {
          image = "ghcr.io/soulverse-ecosystem/nestjs-docker:0.0.1"
          name  = "nestjs-docker"

          # Add resource limits
          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          # Add port
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Add a service for the NestJS deployment
resource "kubernetes_service" "nestjs-docker" {
  depends_on = [kubernetes_deployment.nestjs-docker]

  metadata {
    name = "nestjs-docker"
  }

  spec {
    selector = {
      app = "nestjs-docker"
    }

    port {
      port        = 80
      target_port = 3000  # Adjust to your application port
    }

    type = "LoadBalancer"
  }
}