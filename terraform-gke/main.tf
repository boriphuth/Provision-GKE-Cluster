# data "google_container_engine_versions" "southeast2a" {
#   provider       = google-beta
#   location       = "asia-southeast2-a"
#   version_prefix = "1.18."
# }

resource "google_container_cluster" "default" {
  name        = var.name
  project     = var.project
  description = "K8s GKE Cluster"
  location    = var.location
  min_master_version = "latest"

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default" {
  name       = "${var.name}-node-pool"
  project    = var.project
  location   = var.location
  cluster    = google_container_cluster.default.name

  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

