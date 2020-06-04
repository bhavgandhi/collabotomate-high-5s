resource "kubernetes_namespace" "development" {
  metadata {
    name = "dev"
  }
}


resource "kubernetes_namespace" "qa" {
  metadata {
    name = "qa"
  }
}

