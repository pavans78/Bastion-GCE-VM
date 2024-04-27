/*
This file contains the configuration of a GCP instance to use as a bastion instance.
A bastion instance is an accessible instance within an otherwise unaccessible network that is
most often used when a VPN is not available
*/

# This template will be rendered and used as the startup script for the bastion.
# It installs kubectl and configures it to access the GKE cluster.

data "template_file" "startup_script" {
  template = <<EOF
sudo apt-get update -y
sudo apt-get install -y kubectl
echo "gcloud container clusters get-credentials $${cluster_name} --zone $${cluster_zone} --project $${project}" >> /etc/profile
EOF

  vars = {
    cluster_name = var.cluster_name
    cluster_zone = var.main.zone
    project = var.main.project
  }
}



resource "google_compute_instance" "bastion" {
  name = var.bastion_name
  machine_type = var.bastion_machine_type
  zone = var.main.zone
  project = var.main.project
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cluster-subnet.self_link
    access_config {
      // Implicit ephemeral IP
    }
  }

  // Ensure that when the bastion host is booted, it will have kubectl.

  metadata_startup_script = data.template_file.startup_script.rendered

  // Necessary scopes for administering kubernetes.
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }

}
