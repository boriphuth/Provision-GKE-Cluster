output "endpoint" {
  value = google_container_cluster.default.endpoint
}

output "master_version" {
  value = google_container_cluster.default.master_version
}

# output "stable_channel_version" {
#   value = data.google_container_engine_versions.southeast2a.release_channel_default_version["STABLE"]
# }
