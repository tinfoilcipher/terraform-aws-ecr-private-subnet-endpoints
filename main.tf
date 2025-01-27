resource "aws_vpc_endpoint" "endpoints" {
  count               = length(local.vpc_endpoints)
  vpc_id              = var.vpc_id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  service_name        = local.vpc_endpoints[count.index]
  security_group_ids  = [aws_security_group.sg.id]
  subnet_ids          = local.private_subnet_ids
  tags = {
    Name = "${var.service_name}-vpc-endpoint-${count.index}"
  }
}

resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = var.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids   = local.private_route_table_ids
  tags = {
    Name = "${var.service_name}-vpc-endpoint-s3"
  }
}
