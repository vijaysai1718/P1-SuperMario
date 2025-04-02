data "aws_vpc" "default" {
   default = true
}

data "aws_subnets" "pubilc" {
    filter {
      name = "vpc-id"
      values = [aws_vpc.default.default.id]
    }
    filter {
      name = "Availability Zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]
    }
}