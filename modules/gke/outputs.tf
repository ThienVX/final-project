output "gke_cluster_name" {
  value = google_container_cluster.primary.name
}

output "node_pool_1_name" {
  value = google_container_node_pool.primary_nodes_1.name
}

#output "node_pool_2_name" {
#  value = google_container_node_pool.primary_nodes_2.name
#}
