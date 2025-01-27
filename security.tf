resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.service_name}-ecs-accesspoints-sg"
  }
}

#--DNS Queries (Allows Endpoints/ECR Repos to be resolved)
resource "aws_vpc_security_group_ingress_rule" "ecs_access_points_dns" {
  count             = length(data.aws_subnet.private)
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = data.aws_subnet.private[count.index].cidr_block
  from_port         = 53
  ip_protocol       = "udp"
  to_port           = 53
}

#--HTTP and HTTPS, allows images to be pulled, for some reason just allowing HTTP doesn't do the trick
#--this suggests that part of the proceess still relies of normal HTTP!
resource "aws_vpc_security_group_ingress_rule" "ecs_access_points_http" {
  count             = length(data.aws_subnet.private)
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = data.aws_subnet.private[count.index].cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ecs_access_points_https" {
  count             = length(data.aws_subnet.private)
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = data.aws_subnet.private[count.index].cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

#--Allow all egress back from ECS. Connections are supposed to be stateful, however blocking
#--egress blocks all traffic. A reasonable allowance to make since ECR really has no way to
#--initiate new connections.
resource "aws_vpc_security_group_egress_rule" "ecs_access_points_all" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  ip_protocol       = "-1"
  to_port           = -1
}
