// Subnetwork for the GKE cluster.
resource "google_compute_subnetwork" "cluster-subnet" {
  name          = var.subnet_name
  project       = var.main.project
  ip_cidr_range = var.ip_range
  network       = google_compute_network.network.self_link
  region        = var.main.region

  // A named secondary range is mandatory for a private cluster, this creates it.
  secondary_ip_range {
    range_name    = "secondary-range"
    ip_cidr_range = var.secondary_ip_range
  }
}

resource "google_compute_network" "network" {
  name                    = var.vpc_name
  project                 = var.main.project
  auto_create_subnetworks = false
}