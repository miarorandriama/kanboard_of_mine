# Module EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "kb_cluster"
  cluster_version = "1.31"
  
  cluster_endpoint_public_access = true
  
  vpc_id                   = aws_vpc.kb_vpc.id
  subnet_ids               = [aws_subnet.kb_subnet_2a.id, aws_subnet.kb_subnet_2b.id, aws_subnet.kb_subnet_2c.id]
  control_plane_subnet_ids = [aws_subnet.kb_subnet_2a.id, aws_subnet.kb_subnet_2b.id, aws_subnet.kb_subnet_2c.id]

  eks_managed_node_groups = {
    green_master = {
      min_size       = 2
      max_size       = 5
      desired_size   = 2
      instance_types = ["t2.medium"]
      key_name       = "eni-master"
    }
  }

  tags = {
    "Name" = "kb_cluster"
  }
}