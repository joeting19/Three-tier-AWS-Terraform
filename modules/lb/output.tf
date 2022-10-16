output "public-lb-tg-arn" {
    value = aws_alb_target_group.public-lb-tg.arn     
}

output "private-lb-tg-arn" {
    value = aws_alb_target_group.private-lb-tg.arn     
}
