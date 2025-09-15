resource "docker_container" "postgre" {
  name  = "postgre-${terraform.workspace}"
  image = "postgres:13-trixie"

  ports {
    internal = 5432
    external = var.postgre_external_port[terraform.workspace]
  }
}