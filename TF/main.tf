resource "aws_instance" "example" {
  ami = "ami-03f65b8614a860c29"
  instance_type = "t2.medium"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  associate_public_ip_address = true 


  root_block_device {
    volume_size = 30
  }

  tags = {
    Name        = local.Name
    Project     = local.Project
    Application = local.Application
    Environment = local.Environment
    Owner       = local.Owner
  }
  

  key_name = "s4-session" # specify your key name if you want SSH access


    # Use the file provisioner to copy the local script to the EC2 instance


  provisioner "file" {
      source      = "/a/weather-app"
      destination = "/home/ubuntu/weather-app"
      connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("/a/s4-session.pem")
        host        = self.public_ip
      }
  }

    provisioner "remote-exec" {
      inline = [
        
        "cd /home/ubuntu/weather-app",
        "bash docker.sh"
      ]
  
      connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("/a/s4-session.pem")
        host        = self.public_ip
      }
    }
    
}


