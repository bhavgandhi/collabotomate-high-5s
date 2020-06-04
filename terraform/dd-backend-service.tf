resource "kubernetes_service" "deloitte_drifters_backend_service" {
  metadata {
    name      = "deloitte-drifters-backend-service"
    namespace = kubernetes_namespace.qa.metadata[0].name

  }

  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = "8082"
    }

    selector = {
      app = "deloitte-drifters-backend"
    }

    type             = "ClusterIP"
    session_affinity = "None"
  }
}
