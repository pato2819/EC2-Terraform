#Recursos para crear un VPC
resource "aws_vpc" "vpc_dev" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-hellow-dev"
  }

}
#Subnets de la VPC

resource "aws_subnet" "subnet_publica" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.vpc_dev.id
  map_public_ip_on_launch = true
}

#Recurso de de enrutamiento 

resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.vpc_dev.id

  tags = {
    Name = "ec2_igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_dev.id

  tags = {
    Name = "ec2_rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.route_table.id
}

# Creando grupos de seguridad ssh-web
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  vpc_id      = aws_vpc.vpc_dev.id
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-ssh"
  }
}

resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Dev VPC Web"
  vpc_id      = aws_vpc.vpc_dev.id
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-web"
  }
}

#crea las instancias ec2

resource "aws_instance" "instance_1" {
  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_publica.id
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  tags = {
    Name = "instance_1"
  }
}

resource "aws_instance" "instance_2" {
  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_publica.id
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]

  tags = {
    Name = "instance_2"
  }
}