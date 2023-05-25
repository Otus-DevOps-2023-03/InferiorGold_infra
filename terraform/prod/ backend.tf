terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "backet-otus"
    region     = "ru-central1"
    key        = "../terraform.tfstate"
    access_key = "YCAU0U"
    secret_key = "YCOHw"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

