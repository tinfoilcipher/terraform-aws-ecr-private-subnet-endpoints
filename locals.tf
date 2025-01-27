locals {
    vpc_endpoint_defs = {
        "1.3" = [
            "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
        ]
        "1.4" = [
            "com.amazonaws.${data.aws_region.current.name}.ecr.dkr",
            "com.amazonaws.${data.aws_region.current.name}.ecr.api"
        ]
        "extended" = [
            "com.amazonaws.${data.aws_region.current.name}.ecs-telemetry",
            "com.amazonaws.${data.aws_region.current.name}.ssm",
            "com.amazonaws.${data.aws_region.current.name}.logs"
        ]
    }
    vpc_endpoints = flatten([local.vpc_endpoint_defs[var.fargate_version], var.configure_additional_endpoints ? local.vpc_endpoint_defs["extended"] : []])
    private_subnet_ids = coalescelist(data.aws_subnets.private.ids, var.private_subnet_ids)
    private_route_table_ids = coalescelist(data.aws_route_tables.private.ids, var.private_route_table_ids)
}
