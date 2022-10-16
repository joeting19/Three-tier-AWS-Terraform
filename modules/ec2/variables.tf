locals {
  common_tags={
    Owner = "Devops Team"
    cs= "joeksting@gmail.com"
    time=formatdate("DD MM YYYY hh:mn ZZZ", timestamp())
  }
  prod_tags={
    Owner = "Prod Team"
    cs= "joeksting@gmail.com"
    time=formatdate("DD MM YYYY hh:mn ZZZ", timestamp())
  }
  dev_tags={
    Owner = "Dev Team"
    cs= "joeksting@gmail.com"
    time=formatdate("DD MM YYYY hh:mn ZZZ", timestamp())
  }

}   
variable "instance_type"{
}

variable "key_name"{
}
variable "ami_list"{}

variable "region"{
  type   = string
}

variable "ami_id_managed" {
  type = map(string)
}
variable "instance_profile_name" {
} 
variable "bastionsg_id"{
}
variable "pubsubnet1_id"{
}
variable "pubsubnet2_id"{
}
variable "privsubnet1_id"{
}
variable "privsubnet2_id"{
}
variable "webinstancesg_id"{
}
variable "appinstancesg_id"{
}
variable "private-lb-tg-arn"{
}
variable "public-lb-tg-arn"{
}
