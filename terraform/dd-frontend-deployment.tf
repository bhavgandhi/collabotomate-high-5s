resource "kubernetes_deployment" "deloitte_drifters_frontend" {
  metadata {
    name      = "deloitte-drifters-frontend"
    namespace = kubernetes_namespace.qa.metadata[0].name

    labels = {
      app = "deloitte-drifters-frontend"
    }

  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "deloitte-drifters-frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "deloitte-drifters-frontend"
        }
      }

      spec {
        container {
          name  = "deloitte-drifters-frontend"
          image = "${var.external_image}"

          port {
            name           = "events-port"
            container_port = 8082
            protocol       = "TCP"
          }

          env {
            name  = "PORT"
            value = "80"
          }

          env {
            name  = "SERVER"
            value = "${var.SERVER}"
          }

          resources {
            limits {
              cpu    = "500m"
              memory = "512Mi"
            }

            requests {
              cpu    = "100m"
              memory = "256Mi"
            }
          }

          liveness_probe {
            http_get {
              path   = "/"
              port   = "80"
              scheme = "HTTP"
            }

            initial_delay_seconds = 60
            timeout_seconds       = 1
            period_seconds        = 60
            success_threshold     = 1
            failure_threshold     = 3
          }

          termination_message_path = "/dev/termination-log"
          image_pull_policy        = "IfNotPresent"
        }

        restart_policy                   = "Always"
        termination_grace_period_seconds = 30
        dns_policy                       = "ClusterFirst"
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_unavailable = "25%"
        max_surge       = "25%"
      }
    }

    revision_history_limit    = 10
    progress_deadline_seconds = 600
  }
}

