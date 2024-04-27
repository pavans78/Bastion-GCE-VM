resource "google_compute_firewall" "bastion-ssh" {
  name          = "bastion-ssh"
  network       = google_compute_network.network.self_link
  direction     = "INGRESS"
  project       = var.main.project
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = "dev"
}

