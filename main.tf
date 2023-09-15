resource "esxi_guest" "default" {
  guest_name     = var.guest
  numvcpus       = var.numvcpus
  memsize        = var.memsize
  boot_disk_size = var.boot_disk_size
  disk_store     = var.disk_store
  network_interfaces {
    virtual_network = var.virtual_network
  }
  ovf_source = var.ovf_file
  ovf_properties {
    key   = "instance-id"
    value = random_id.instance_id.hex
  }
  ovf_properties {
    key   = "hostname"
    value = var.guest
  }
  # ovf_properties {
  #   key   = "password"
  #   value = "RANDOM"
  # }
  ovf_properties {
    key = "public-keys"
    # error if new-line inside, so we chomp it
    value = chomp(tls_private_key.rsa-4096.public_key_openssh)
  }

  provisioner "file" {
    source      = var.script_file
    destination = "/tmp/${var.script_file}"
    connection {
      type        = "ssh"
      host        = self.ip_address
      user        = var.default-ssh-user
      timeout     = "15s"
      private_key = tls_private_key.rsa-4096.private_key_openssh
      agent       = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.ip_address
      user        = var.default-ssh-user
      timeout     = "15s"
      private_key = tls_private_key.rsa-4096.private_key_openssh
      agent       = false
    }
    inline = [
      #"echo '${var.default_password}' | sudo -S hostnamectl set-hostname ${var.guest}",
      "chmod +x /tmp/${var.script_file}",
      "bash /tmp/${var.script_file}",
      "sudo -S hostnamectl set-hostname ${var.guest}"
    ]
  }
}