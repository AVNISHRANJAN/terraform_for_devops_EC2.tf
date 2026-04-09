variable "instances" {

  description = "Map of instance configurations"
  type = map(object({
    ami        = string
    ssh_user   = string
    os_family  = string
  }))

  default = {
    Controll_node_Ubuntu= {
      ami        = "ami-0c3389a4fa5bddaad"
      ssh_user   = "ubuntu"
     os_family  = "ubuntu"
    }

    worker1_Ubuntu = {
      ami        = "ami-0c3389a4fa5bddaad"
      ssh_user   = "ubuntu"
      os_family  = "ubuntu"
    }

    worker2_RedHat = {
      ami        = "ami-056244ee7f6e2feb8"
      ssh_user   = "ec2-user"
      os_family  = "redhat"
    }

    worker3_Amazon = {
      ami        = "ami-01b14b7ad41e17ba4"
      ssh_user   = "ec2-user"
      os_family  = "amazon"
    }
  }
}