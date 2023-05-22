#terraform {
#  required_providers {
#    yandex = {
#      source  = "yandex-cloud/yandex"
#      version = "0.89.0"
#    }
#  }
#}

resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  zone = var.zone

  labels = {
    tags = "reddit-db"
  }

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "null_resource" "db" {
  
 connection {
    type        = "ssh"
    host        = yandex_compute_instance.db.network_interface[0].nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = var.private_key_path
 }
  # provisioner "remote-exec" {
  #   script = "${path.module}/files/deploy.sh"
  # }
}
