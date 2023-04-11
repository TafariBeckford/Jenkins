
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-instance"

  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t3.medium"
  key_name               = data.aws_key_pair.key.key_name
  monitoring             = true
  vpc_security_group_ids = data.aws_security_groups.sg.ids
  
  user_data = <<-EOT
        #!/bin/bash

            curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
                /usr/share/keyrings/jenkins-keyring.asc > /dev/null

            echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
            https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
            /etc/apt/sources.list.d/jenkins.list > /dev/null

            sudo apt-get update -y
            sudo apt-get install openjdk-11-jre -y
            sudo apt-get install jenkins -y
            sudo systemctl enable jenkins
            sudo systemctl start jenkins
  
  

EOT

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

data "aws_key_pair" "key" {
  key_pair_id = "key-0c2416d93a8adfde3"
  include_public_key = true
}

data "aws_security_groups" "sg" {
  tags = {
    name = "jenkins"
    
  }
}