# output "internal_ip_address_app" {
#   value = yandex_compute_instance.app[0].network_interface.0.ip_address
# }

# output "lb_address_add" {
#   value = [for s in yandex_lb_network_load_balancer.foo.listener: [for a in s.external_address_spec: a.address].0].0

# }
# output "external_ip_address_app" {
#   value = yandex_compute_instance.app.network_interface.0.nat_ip_address
# }

# output "external_ip_address_db" {
#   value = yandex_compute_instance.db.network_interface.0.nat_ip_address
# }

output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}