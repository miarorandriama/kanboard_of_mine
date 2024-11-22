# Création des rôles IAM pour EKS
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attachement de la politique Full Access pour les nœuds
resource "aws_iam_role_policy" "eks_node_full_access_policy" {
  name   = "eks-node-full-access-policy"
  role   = aws_iam_role.eks_node_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}

# Attachement de la politique Full Access pour le cluster
resource "aws_iam_role_policy" "eks_cluster_full_access_policy" {
  name   = "eks-cluster-full-access-policy"
  role   = aws_iam_role.eks_cluster_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}
