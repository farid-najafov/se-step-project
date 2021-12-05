resource "aws_launch_template" "app_node" {
  name = "lt-phonebook"
  instance_type = "t2.micro"
  image_id = "ami-01cc34ab2709337aa"
  key_name = "my-key-pair"
  instance_initiated_shutdown_behavior = "terminate"
  update_default_version = true

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.be.id]
  }

  placement {
    availability_zone = "us-east-1a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "phonebook-app"
    }
  }

  user_data = filebase64("user_data.sh")
}