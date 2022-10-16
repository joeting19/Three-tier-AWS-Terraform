resource "aws_alb" "Web-facing-LB" {
  name               = "web-facing-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.publbsg_id]
  subnets            = [var.pubsubnet1_id, var.pubsubnet2_id]
  tags = {
    Name = "Public-LB"
  }
}

resource "aws_route53_record" "AliasRecord" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_alb.Web-facing-LB.dns_name
    zone_id                = aws_alb.Web-facing-LB.zone_id
    evaluate_target_health = true
  }
}

resource "aws_alb" "App-tier-LB" {
  name               = "private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.privlbsg_id]
  subnets            = [var.privsubnet1_id, var.privsubnet2_id]
  tags = {
    Name = "Private-LB"
  }
}

resource "aws_alb_target_group" "public-lb-tg" {
  name     = "public-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/health"
    port = 80
  }
}

resource "aws_alb_target_group" "private-lb-tg" {
  name     = "private-lb-tg"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/health"
    port = 4000
  }
}

resource "aws_alb_listener" "pub-listener_http" {
  load_balancer_arn = "${aws_alb.Web-facing-LB.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.public-lb-tg.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "pub-listener_https" {
  load_balancer_arn = "${aws_alb.Web-facing-LB.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   =var.acm_certificate_arn

  default_action {
    target_group_arn = "${aws_alb_target_group.public-lb-tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_alb_listener.pub-listener_https.arn
  certificate_arn = var.acm_certificate_arn
}

resource "aws_alb_listener" "priv-listener_http" {
  load_balancer_arn = "${aws_alb.App-tier-LB.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.private-lb-tg.arn}"
    type             = "forward"
  }
}


