# Route table pour les sous-réseaux publics
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id  # ID du VPC existant

#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.kb_internet_gateway.id
#  }
#
#  route {
#    cidr_block = "10.0.0.0/16"
#    gateway_id = "local"
#  }
#
#  tags = {
#    Name = "public-route-table"
#  }
}

# Route vers l'Internet Gateway pour les sous-réseaux publics
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"  # Tout le trafic vers Internet
  gateway_id             = aws_internet_gateway.main.id  # Internet Gateway
}

# Route pour les communications internes au VPC (Public Subnets)
resource "aws_route" "public_vpc_internal" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = aws_vpc.main.cidr_block  # Trafic interne au VPC
  gateway_id             = null                     # Trafic reste interne
}

# Association de la route table publique aux sous-réseaux publics
resource "aws_route_table_association" "public_subnets" {
  count          = 3  # Associez les 3 sous-réseaux publics
  subnet_id      = element([aws_subnet.kb_public_subnet_1.id, aws_subnet.kb_public_subnet_2.id, aws_subnet.kb_public_subnet_3.id], count.index)
  route_table_id = aws_route_table.public.id
}

# Route table pour les sous-réseaux privés
#resource "aws_route_table" "private" {
#  vpc_id = aws_vpc.kb_vpc.id
#
#  tags = {
#    Name = "private-route-table"
#  }
#}

# Route vers la NAT Gateway pour les sous-réseaux privés
#resource "aws_route" "private_nat_access" {
#  route_table_id         = aws_route_table.private.id
#  destination_cidr_block = "0.0.0.0/0"  # Tout le trafic sortant passe par la NAT Gateway
#  nat_gateway_id         = aws_nat_gateway.kb_natgw.id
#}

# Association de la route table privée aux sous-réseaux privés
#resource "aws_route_table_association" "private_subnets" {
#  count          = 3  # Associez les 3 sous-réseaux privés
#  subnet_id      = element([aws_subnet.kb_private_subnet_1.id, aws_subnet.kb_private_subnet_2.id, aws_subnet.kb_private_subnet_3.id], count.index)
#  route_table_id = aws_route_table.private.id
#}
