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
  access_key = AKIA6JURZXSOPPK3UL5B
  secret_key = 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
  region     = var.aws_region
}