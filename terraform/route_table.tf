# Routetable
resource "aws_route_table" "kb_routetable" {
  vpc_id = aws_vpc.kb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kb_internet_gateway.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

# Route Table Association
resource "aws_route_table_association" "kb_subnet_2a_association" {
  subnet_id      = aws_subnet.kb_subnet_2a.id
  route_table_id = aws_route_table.kb_routetable.id
}

resource "aws_route_table_association" "kb_subnet_2b_association" {
  subnet_id      = aws_subnet.kb_subnet_2b.id
  route_table_id = aws_route_table.kb_routetable.id
}

resource "aws_route_table_association" "kb_subnet_2c_association" {
  subnet_id      = aws_subnet.kb_subnet_2c.id
  route_table_id = aws_route_table.kb_routetable.id
}