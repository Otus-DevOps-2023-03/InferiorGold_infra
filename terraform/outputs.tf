output "external_ip_address_app" {
  value = yandex_compute_instance.app.*.network_interface.0.nat_ip_address
}
output "external_ip_address_balancer" {
  value = [for s in yandex_lb_network_load_balancer.foo.listener: [for a in s.external_address_spec: a.address].0].0
  #value = yandex_lb_network_load_balancer.foo.listener[*].external_address_spec[*].address
}
