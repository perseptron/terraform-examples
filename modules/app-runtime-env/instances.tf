resource "google_compute_instance_template" "default" {
  name        = var.template_name
  machine_type         = var.machine_type

  // Create a new boot disk from an image
  disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
  }

  network_interface {
    network = var.vpc_network_name
    subnetwork = var.vpc_subnet_name
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.template_sa
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group_manager" "webserver" {
  name = var.MIG_name

  base_instance_name = "webserver"
  zone               = var.zone

  version {
    instance_template  = google_compute_instance_template.default.self_link_unique
  }

  target_size = 1
}

resource "google_compute_autoscaler" "scaler" {
  name   = var.autoscaler_name
  target = google_compute_instance_group_manager.webserver.id
  zone = var.zone
  autoscaling_policy {
    max_replicas    = 4
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
    scaling_schedules {
     name = "test"
     min_required_replicas = 4
     duration_sec = 300

     schedule = "12 12 12 12 *"
     time_zone = "Europe/Kiev"
    }

    scaling_schedules {
     name = "busytime"
     min_required_replicas = 2
     duration_sec = 43200

     schedule = "0 8 * * *"
     time_zone = "Europe/Kiev"
    }
  }
}