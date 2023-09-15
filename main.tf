resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = "false"
  #delete_default_routes_on_create = "true"
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc_network.id
}


resource "google_compute_instance" "ssrv" {
  name         = var.instance_name
  machine_type = var.instance_type

  tags = var.network_tags
  labels = {
    environment = var.environment
  }

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
    }
  }

  network_interface {

    subnetwork = google_compute_subnetwork.vpc_subnet.id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file(var.startup)

}

resource "google_compute_firewall" "default" {
  name    = "ssrv-task1-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.network_tags
}
