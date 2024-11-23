resource "aws_security_group" "eks_cluster" {
  vpc_id = aws_vpc.kb_vpc.id
  name   = "eks-cluster-sg"

  # Ports pour la communication des nœuds
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Ports pour la communication du plan de contrôle
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Ou spécifiez une plage d'adresses IP plus restreinte si nécessaire
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


# Création des groupes de sécurité pour les nœuds EKS
resource "aws_security_group" "eks_node" {
  vpc_id = aws_vpc.kb_vpc.id
  name   = "eks-node-sg"


  # Ports pour la communication du plan de contrôle
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ports pour la communication des nœuds
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10256
    to_port     = 10256
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}  

# Accès à RDS
resource "aws_security_group" "kb_sg_rds" {
  name        = "kb_sg_rds"
  description = "Security group for RDS MariaDB instance"
  vpc_id      = aws_vpc.kb_vpc.id

  # Accès à la base de données sur le port 3306
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.web_application.id]  # Accessible depuis l'application
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#  tags = {
#    Name = "rds-mariadb-sg"
#  }
}

# Accès à EFS
resource "aws_security_group" "kb_sg_efs" {
  name        = "kb_sg_efs"
  description = "Security group for EFS storage"
  vpc_id      = aws_vpc.main.id

  # Accès au système de fichiers sur le port 2049
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.kb_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#  tags = {
#    Name = "efs-sg"
#  }
}


#Pour cette mise en production, voici comment sera l'architecture de mon projet:
#Dans un vpc, je vais créer et configurer un cluste EKS. Ce dernier aura 3 worker nodes qui auront à leur tour 1 pod chacun.
#Mon application devant être accessible depuis des navigateurs web devront recevoir des requêtes sur les ports 80 et 443.
#Pour la maintenance, on veut que l'application puiss recevoir des connexions ssh donc le port 22 aussi sera ouvert.
#La base de données utilisée par mon application est une instance RDS MariaDB donc elle devra communiquer sur le port 3306.
#Pour stocker les données de l'application, j'utilise aussi un système de fichier EFS qui utilise le port 2049.
#Je ne connais pas comment fonctionne la communication dans un cluster K8s, mais il me semble que certains composants de ce dernier doivent communiquer sur des ports spécifiques si je ne m'abuse.
#En bref, voilà comment est structuré mon projet de mise en production. Rédige un manifest pour tous les security groups dont mon application aura besoin.