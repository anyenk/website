
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["prod-vpc"]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name   = "tag:Name"
    values = ["prod-public-a"]
  }

  filter {
    name   = "availabilityZone"
    values = ["sa-east-1a"]
  }

  vpc_id = data.aws_vpc.main.id
}

data "aws_subnet" "public_b" {
  filter {
    name   = "tag:Name"
    values = ["prod-public-b"]
  }

  filter {
    name   = "availabilityZone"
    values = ["sa-east-1b"]
  }

  vpc_id = data.aws_vpc.main.id
}

