variable "aws_region" {
  description = "region donde se trabaja el proyecto"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "tipo de instancia"
  type        = string
  default     = "t2.micro"
}