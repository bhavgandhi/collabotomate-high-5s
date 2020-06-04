resource "kubernetes_namespace" "development" {
  metadata {
    name = "development"
  }
}


resource "kubernetes_namespace" "qa" {
  metadata {
    name = "qa"
  }
}

