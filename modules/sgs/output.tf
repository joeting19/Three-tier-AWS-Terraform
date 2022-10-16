output "bastionsg_id" {
    value = aws_security_group.Bastion-SG.id 
}
output "publbsg_id" {
    value = aws_security_group.web-facing-LB-SG.id 
}
output "webinstancesg_id" {
    value = aws_security_group.web-tier-instance-SG.id 
}
output "privlbsg_id" {
    value = aws_security_group.internal-LB-SG.id 
}
output "appinstancesg_id" {
    value = aws_security_group.app-tier-instance-SG.id 
}
output "dbsg_id" {
    value = aws_security_group.DB-SG.id 
}