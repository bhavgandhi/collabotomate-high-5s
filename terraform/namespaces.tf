resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}


resource "kubernetes_namespace" "qa" {
  metadata {
    name = "qa"
  }
}

