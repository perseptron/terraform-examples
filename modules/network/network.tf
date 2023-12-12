resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
  auto_create_subnetworks = var.auto_subnet
  mtu = var.mtu
  routing_mode = var.mode
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = var.vpc_subnet_name
  ip_cidr_range = var.vpc_subnet_CIDR
  network       = google_compute_network.vpc_network.id
}

// we need this for configuring NAT
resource "google_compute_router" "router" {
  name    = var.router_name
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name   = local.nat_name
  router = google_compute_router.router.name

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }
  source_ranges = var.allowed_source
}