# Internet Gateway
resource "aws_internet_gateway" "kb_internet_gateway" {
  vpc_id = aws_vpc.kb_vpc.id
}