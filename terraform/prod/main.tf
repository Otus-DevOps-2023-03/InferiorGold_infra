#  terraform {
#    required_providers {
#      yandex = {
#        source  = "yandex-cloud/yandex"
#        version = "0.89.0"
#      }
#    }
#  }

provider "yandex" {
  service_account_key_file = pathexpand(var.service_account_key_file)
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  private_key_path = file(var.private_key_path)
  db_ip           = module.db.external_ip_address_db
  #prov            = var.prov

}
module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
  private_key_path = file(var.private_key_path)
}

# resource "yandex_compute_instance" "app" {
#   count = var.count_app
#   name = "reddit-app-${count.index}"

#   resources {
#     cores         = 2
#     memory        = 1
#     core_fraction = 5
#   }
#   metadata = {
#     ssh-keys = "ubuntu:${file(var.public_key_path)}"
#   }

#   boot_disk {
#     initialize_params {
#       # Указать id образа созданного в предыдущем домашем задании
#       image_id = var.image_id
#     }
#   }

#   network_interface {
#     # Указан id подсети default-ru-central1-a
#     subnet_id = var.subnet_id
#     nat       = true
#   }

#   connection {
#     type  = "ssh"
#     host  = self.network_interface.0.nat_ip_address
#     user  = "ubuntu"
#     agent = false
#     # путь до приватного ключа
#     private_key = file(var.private_key_path)
#   }

#   provisioner "file" {
#     source      = "files/puma.service"
#     destination = "/tmp/puma.service"
#   }
#   provisioner "remote-exec" {
#     script = "files/deploy.sh"
#   }
# }

