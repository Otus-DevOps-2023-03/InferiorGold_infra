resource "yandex_lb_network_load_balancer" "foo" {
  name = "lb-test"
  
  listener {
    name = "balancer"
    port = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
    attached_target_group {
      target_group_id = yandex_lb_target_group.foo.id
      healthcheck {
        name = "http"
        http_options {
          port = "9292"
          path = "/"
        }
      }
    }
  }


resource "yandex_lb_target_group" "foo" {
  name = "lb-group"
  dynamic "target" {
    for_each = yandex_compute_instance.app.*.network_interface.0.ip_address
    content {
      address   = target.value
      subnet_id = var.subnet_id
    }
}
}
