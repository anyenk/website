
resource "aws_instance" "wordpress" {
  ami           = "ami-02e6c834d44f57b3e" # Amazon Linux 2023 - sa-east-1
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.wordpress.id]

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
