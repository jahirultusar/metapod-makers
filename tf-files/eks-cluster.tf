module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  #Adding the fllowing two lines so
  #Cluster public access is enabled and can be accessed 
  # Remotely aka via local machine
  # recommendation: have it as private endpoint 

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  subnet_ids = data.aws_subnets.vpc_subnets.ids
  vpc_id     = aws_default_vpc.default_vpc.id

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    group_1 = {
      name           = "worker-group-1"
      instance_types = ["t2.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2


      vpc_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }

    group_2 = {
      name           = "worker-group-2"
      instance_types = ["t2.medium"] # t2.medium is getting old!
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      vpc_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
    }
  }

  tags = {
    Environment = "training"
  }
}
