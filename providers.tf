#Terraform block
#En este bloque se encuentra informacion de la version de terraform (terrafom version) y el proveedor que se utilizara (disponible en https://registry.terraform.io/)
terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#provider block
#En este bloque se encuentra las credenciales de acceso al proveedor ( en este caso aws https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}


