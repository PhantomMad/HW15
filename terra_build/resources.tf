resource "yandex_compute_instance" "vm_build" {
  name = "buildsrv"

  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.size_hd
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("~/terra_build/users.txt")}"
  }
  provisioner "file" {
    source      = var.maven_gz
    destination = "/tmp/${var.maven_gz}"
  }
  provisioner "file" {
    source      = "deployment.sh"
    destination = "/tmp/deployment.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/deployment.sh", "sudo /tmp/deployment.sh ${var.git_url} ${var.maven_gz}", ]
  }
  connection {
    type        = "ssh"
    user        = "devopsadmin"
    host        = self.network_interface.0.nat_ip_address
    agent       = false
    private_key = file("~/.ssh/id_rsa")
  }
}
