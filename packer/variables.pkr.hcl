variable "source_ami" {
  default = "ami-0fa1de1d60de6a97e"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "region" {
  default = "us-east-1"
}

variable "ssh_username" {
  default = "ec2-user"
}

variable "security_group_id" {
  default = "sg-0022ddab3a95e94fc"
}