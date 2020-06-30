resource "kubernetes_service" "deloitte_drifters_frontend_service" {
  metadata {
    name      = "deloitte-drifters-frontend-service"
    namespace = kubernetes_namespace.master.metadata[0].name
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8080
      node_port   = 30345
    }

    selector = {
      app = "deloitte-drifters-frontend"
    }

    type                    = "LoadBalancer"
    session_affinity        = "None"
    external_traffic_policy = "Cluster"
  }
}

