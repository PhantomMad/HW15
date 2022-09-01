resource "yandex_compute_instance" "vm_prod" {
  name = "prodsrv"

  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = var.size_hd
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
    user-data = "${file("~/terra_prod/users.txt")}"
  }
  provisioner "file" {
    source      = var.tomcat_gz
    destination = "/tmp/${var.tomcat_gz}"
  }
  provisioner "file" {
    source      = "deployment.sh"
    destination = "/tmp/deployment.sh"
  }
  provisioner "file" {
    source      = ".passwd-s3fs"
    destination = "/tmp/.passwd-s3fs"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/deployment.sh", "sudo /tmp/deployment.sh ${var.tomcat_gz}", ]
  }
  connection {
    type        = "ssh"
    user        = "devopsadmin"
    host        = self.network_interface.0.nat_ip_address
    agent       = false
    private_key = file("~/.ssh/id_rsa")
  }

}
