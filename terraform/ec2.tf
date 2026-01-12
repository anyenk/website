
resource "aws_instance" "wordpress" {
  ami           = "ami-0d1ddd83282187d18" # Amazon Linux 2023 - sa-east-1
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.public_a.id

  tags = {
    Name = "wordpress-prod"
  }

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd php php-mysqlnd mariadb-server
              systemctl enable httpd
              systemctl start httpd
              systemctl enable mariadb
              systemctl start mariadb
              EOF
}
