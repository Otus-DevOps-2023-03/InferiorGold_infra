terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "backet-otus"
    region     = "ru-central1"
    key = "../terraform.tfstate"
    access_key = "YCAJE1NEpXODIKzKjNnXZxU0U"
    secret_key = "YCOHEHb-DnRg_1NCGCCJUcOzhMaiwOvj9sGeuciw"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

