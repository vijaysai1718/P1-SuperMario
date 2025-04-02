#creating the key pair 
resource "aws_key_pair" "key" {
  key_name = "InstanceConnectionKey"
  public_key =("E:/DevopsAws/devopsvija.pub")
  
}

#creating the Security Group 
resource "aws_security_group" "allow_ssh" {
  name ="allow_ssh"
  description = "Allow SSH and HTTP inbound traffic"
  ingress{
   from_port ="22"
   to_port = "22"
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
    ingress{
   from_port ="80"
   to_port = "80"
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

    egress{
   from_port ="0"
   to_port = "0"
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "allow_ssh"
  }
}

resource "aws_instance" "superMario" {
  ami= data.aws_ami.ubuntu.id
  instance_type ="t3.micro"
  key_name = data.aws_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    name ="supermarioInstance"
  }
}



# resource "aws_eks_cluster" "cluster" {
#   name = "super_mario"
#   version = "1.30"
#   role_arn=""
#   vpc_config {
#     subnet_ids =data.aws_subnets.pubilc.ids
#   }
# tags = {
#   Name ="super_mario"

# }
 
# depends_on = [ aws_iam_role.aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy]
# }

# resource "aws_iam_role" "example" {
#   name               = "eks-cluster-cloud"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.example.name
# }




# #cluster provision
# resource "aws_eks_cluster" "example" {
#   name     = "EKS_CLOUD1"
#       role_arn = aws_iam_role.example.arn


#   version = "1.30"
  
#   vpc_config {
#      subnet_ids    = data.aws_subnets.public.ids

#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#   ]
# }

# resource "aws_iam_role" "example1" {
#   name = "eks-node-group-cloud"

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.example1.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.example1.name
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.example1.name
# }

# #create node group
# resource "aws_eks_node_group" "example" {
#   cluster_name    = aws_eks_cluster.example.name
#   node_group_name = "Node-cloud"
#   node_role_arn   = aws_iam_role.example1.arn
#   subnet_ids      = data.aws_subnets.public.ids

#   scaling_config {
#     desired_size = 1
#     max_size     = 2
#     min_size     = 1
#   }
#   instance_types = ["t2.medium"]

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
#   tags ={
#     Name= "Node-cloud"
#   }
# }
