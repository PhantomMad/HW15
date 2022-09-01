output "internal_ip_address_build" {
  value = yandex_compute_instance.vm_build.network_interface.0.ip_address
}
output "external_ip_address_build" {
  value = yandex_compute_instance.vm_build.network_interface.0.nat_ip_address
}
