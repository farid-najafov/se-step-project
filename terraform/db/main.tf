provider "aws" {
  allowed_account_ids = [705694785258]
  region = "us-east-1"
}

resource "aws_security_group" "db" {
  name = "tf-db"

  ingress {
    from_port = 3306
    protocol = "TCP"
    to_port = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 65535
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "Security rules for mysql db"

  tags = {
    Name = "db-ph"
  }
}

resource "aws_instance" "db_mysql" {
  ami = "ami-01cc34ab2709337aa"
  instance_type = "t2.micro"
  key_name = "my-key-pair"

  tags = {
    Name = "mysql db"
  }

  vpc_security_group_ids = [aws_security_group.db.id, "sg-03f0afc9972bef360"]

  user_data_base64 = filebase64("user_data.sh")
}