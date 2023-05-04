output "internal_ip_address_app" {
  value = yandex_compute_instance.app[0].network_interface.0.ip_address
}


output "lb_address_add" {
  value = yandex_lb_network_load_balancer.foo.listener[*].external_address_spec[*].address
}
