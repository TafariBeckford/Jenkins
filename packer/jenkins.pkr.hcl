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
    "Name" = "linux-agent"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]


  provisioner "shell" {

    inline = ["sudo yum update –y",
    "sudo yum install git -y",
    "sudo amazon-linux-extras install docker"
    ]
  }

  post-processor "manifest" {

  }
}