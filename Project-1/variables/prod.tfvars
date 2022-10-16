own_ip =["174.3.252.207/32"]
key_name= "ALB-KEY"
region="us-east-1"
vpc_name_tag=["vpc", "pub-subnet1", "pub_subnet2", "priv_subnet1", "priv_subnet2", "priv_subnet3", "priv_subnet4"]
ec2_role="Ec2-SSM-S3"

ami_list= {
    "ubuntu"= "ami-0a6656ad0aedd2886"
    "web_ami"= "ami-06298b1b563a161b6"
    "app_ami"= "ami-026f1d83ebd08d9ab"
}

ami_id_managed= {
    "us-east-1" = "ami-0cff7528ff583bf9a"
    "us-east-2" = "ami-02d1e544b84bf7502"
    "us-west-1" = "ami-0d9858aa3c6322f73"    
    "us-west-2" = "ami-098e42ae54c764c35"
    "ca_central"= "ami-00f881f027a6d74a0"
}

cidr_blocks= {
    "vpc" = "10.0.0.0/16"
    "pub_sn1"= "10.0.10.0/24"
    "pub_sn2"= "10.0.20.0/24"
    "priv_sn1" = "10.0.30.0/24"
    "priv_sn2" = "10.0.40.0/24"
    "priv_sn3" = "10.0.50.0/24"
    "priv_sn4" = "10.0.60.0/24"
}



instance_type="t2.small"