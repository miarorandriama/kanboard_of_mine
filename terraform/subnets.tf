# Subnets
resource "aws_subnet" "kb_subnet_2a" {
  vpc_id                  = aws_vpc.kb_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "kb_subnet_2b" {
  vpc_id                  = aws_vpc.kb_vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "kb_subnet_2c" {
  vpc_id                  = aws_vpc.kb_vpc.id
  cidr_block              = "10.0.32.0/20"
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true
}
