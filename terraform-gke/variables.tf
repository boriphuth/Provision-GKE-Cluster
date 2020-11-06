variable "name" {
  default = "k8s-cluster"
}

variable "project" {
  default = "devsecops-294715"
}

variable "location" {
  default = "asia-southeast2"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-1"
}
variable "kubernetes_version" {
  default = "1.18.9-gke.2501"
}

