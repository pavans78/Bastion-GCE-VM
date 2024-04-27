// Create the primary cluster for this project.

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  project            = var.main.project
  location           = var.main.zone
  network            = google_compute_network.network.self_link
  subnetwork         = google_compute_subnetwork.cluster-subnet.self_link
  initial_node_count = var.initial_node_count
  deletion_protection = false

  // Scopes necessary for the nodes to function correctly
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = var.node_machine_type
    image_type   = "COS_CONTAINERD"

    // (Optional) The Kubernetes labels (key/value pairs) to be applied to each node.
    labels = {
      status = "dev"
    }

    // (Optional) The list of instance tags applied to all nodes.
    // Tags are used to identify valid sources or targets for network firewalls.
    tags = ["dev"]
  }

  // (Required for private cluster, optional otherwise) Configuration for cluster IP allocation.
  // As of now, only pre-allocated subnetworks (custom type with
  // secondary ranges) are supported. This will activate IP aliases.
  ip_allocation_policy {
    cluster_secondary_range_name = "secondary-range"
  }

  // In a private cluster, the master has two IP addresses, one public and one
  // private. Nodes communicate to the master through this private IP address.
  private_cluster_config {
    enable_private_nodes   = true
    master_ipv4_cidr_block = "10.0.90.0/28"
    enable_private_endpoint = false      
  }

  // (Required for private cluster, optional otherwise) network (cidr) from which cluster is accessible
  master_authorized_networks_config {
    cidr_blocks {
      display_name = "bastion"
      cidr_block   = join("/", [google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip, "32"])
    }
  }

}
