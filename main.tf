terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

provider "docker" {
}

# terraform init
# terraform workspace list
# terraform workspace new dev
# terraform plan
# terraform apply -y
# terraform destroy