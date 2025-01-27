data "aws_region" "current" {}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    "${var.private_subnet_tag_key}" = "${var.private_subnet_tag_value}"
  }
}

data "aws_subnet" "private" {
  count  = length(local.private_subnet_ids)
  vpc_id = var.vpc_id
  id     = local.private_subnet_ids[count.index]
}

data "aws_route_tables" "private" {
  vpc_id = var.vpc_id

  filter {
    name   = "tag:${var.private_route_table_tag_key}"
    values = [var.private_route_table_tag_value]
  }
}
