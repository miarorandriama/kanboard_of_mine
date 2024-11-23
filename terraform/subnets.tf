resource "aws_subnet" "kb_public_subnet_1" {
  vpc_id                  = aws_vpc.kb_vpc.id      # ID du VPC existant
  cidr_block              = "10.0.0.0/20"        # Plage pour le sous-réseau public 1
  availability_zone       = "us-east-2a"          # Zone de disponibilité (modifiez selon votre région)
  map_public_ip_on_launch = true                 # Attribuer une IP publique aux instances
#  tags = {
#    Name = "public-subnet-1"
#  }
}

resource "aws_subnet" "kb_public_subnet_2" {
  vpc_id                  = aws_vpc.kb_vpc.id
  cidr_block              = "10.0.16.0/20"       # Plage pour le sous-réseau public 2
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
#  tags = {
#    Name = "public-subnet-2"
#  }
}

resource "aws_subnet" "kb_public_subnet_3" {
  vpc_id                  = aws_vpc.kb_vpc.id
  cidr_block              = "10.0.32.0/20"       # Plage pour le sous-réseau public 3
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true
#  tags = {
#    Name = "public-subnet-3"
#  }
}

#resource "aws_subnet" "kb_private_subnet_1" {
#  vpc_id                  = aws_vpc.kb_vpc.id
#  cidr_block              = "10.0.48.0/20"       # Plage pour le sous-réseau privé 1
#  availability_zone       = "us-east-2a"
#  tags = {
#    Name = "private-subnet-1"
#  }
#}

#resource "aws_subnet" "kb_private_subnet_2" {
#  vpc_id                  = aws_vpc.kb_vpc.id
#  cidr_block              = "10.0.64.0/20"       # Plage pour le sous-réseau privé 2
#  availability_zone       = "us-east-2b"
#  tags = {
#    Name = "private-subnet-2"
#  }
#}

#resource "aws_subnet" "kb_private_subnet_3" {
#  vpc_id                  = aws_vpc.kb_vpc.id
#  cidr_block              = "10.0.80.0/20"       # Plage pour le sous-réseau privé 3
#  availability_zone       = "us-east-2c"
#  tags = {
#    Name = "private-subnet-3"
#  }
#}