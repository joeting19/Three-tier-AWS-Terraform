# terraform plan --var-file=variables/test.tfvars

module "iam" {
  source="../Modules/iam"
  ec2_role=var.ec2_role
}

module "vpc" {
  source="../Modules/vpc"
  vpc_name_tag=var.vpc_name_tag
  cidr_blocks=var.cidr_blocks
}

module "sgs" {
  source="../Modules/sgs"
  own_ip=var.own_ip
  vpc_id= module.vpc.vpc_id
}

#module "db" {
#  source="../Modules/db"
#  dbsg_id = module.sgs.dbsg_id
#  privsubnet3_id= module.vpc.privsubnet3_id
#  privsubnet4_id= module.vpc.privsubnet4_id  
#}
module "lb" {
  source="../Modules/lb"
  zone_id="Z0072456VH0VO2OLB12N"
  domain_name="www.maitriwind.com"
  vpc_id= module.vpc.vpc_id
  publbsg_id= module.sgs.publbsg_id
  privlbsg_id= module.sgs.privlbsg_id
  pubsubnet1_id= module.vpc.pubsubnet1_id
  pubsubnet2_id= module.vpc.pubsubnet2_id
  privsubnet1_id= module.vpc.privsubnet1_id
  privsubnet2_id= module.vpc.privsubnet2_id
  acm_certificate_arn= "arn:aws:acm:us-east-1:701837564712:certificate/ad14c38f-d0e0-487f-81b3-db9bc51f9874"
}


#module "s3" {
#  source="../Modules/s3"
#}

module "ec2" {
  source="../Modules/ec2"
  ami_list=var.ami_list
  ami_id_managed=var.ami_id_managed
  instance_type=var.instance_type
  region=var.region
  key_name=var.key_name
  instance_profile_name= module.iam.instance_profile
  bastionsg_id= module.sgs.bastionsg_id
  webinstancesg_id= module.sgs.webinstancesg_id
  appinstancesg_id= module.sgs.appinstancesg_id
  pubsubnet1_id=module.vpc.pubsubnet1_id
  pubsubnet2_id=module.vpc.pubsubnet2_id
  privsubnet1_id=module.vpc.privsubnet1_id
  privsubnet2_id=module.vpc.privsubnet2_id
  private-lb-tg-arn=module.lb.private-lb-tg-arn
  public-lb-tg-arn=module.lb.public-lb-tg-arn
}



#resource "aws_instance" "test2" {
#  ami = "ami-090fa75af13c156b4"
#  instance_type = "t2.micro"
#  tags = {
#    Name="local-exec-ec2"
#  }
#  provider= aws.awstest19
#
#  provisioner "local-exec" {
#    command = "echo ${aws_instance.test2.public_ip} >> publicip.txt"
#
#  }
#}
