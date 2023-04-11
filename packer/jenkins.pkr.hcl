packer {
  required_plugins {
    amazon = {
      version = " >= 1.2.2 "
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "jenkins" {
  ami_name      = "Jenkins {{timestamp}}"
  instance_type = "${var.instance_type}"
  region        = var.region
  source_ami    = "${var.source_ami}"
  ssh_username  = var.ssh_username


  tags = {
    "Name" = "jenkins-slave"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]


  provisioner "shell" {

    inline = ["sudo yum update –y",
    "sudo amazon-linux-extras install java-openjdk11 -y",
    "sudo yum install git -y"]
  }

  post-processor "manifest" {

  }
}