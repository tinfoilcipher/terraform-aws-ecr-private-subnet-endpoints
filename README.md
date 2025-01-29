# Terraform Module - ECR VPC Endpoints for Private Subnets

Terraform Module to create appropriate VPC Endpoints to access ECR from private subnets (truly private subnets with no access to the internet).

Creates VPC interface Endpoints for ECR and S3 Gateway Endpoint (which is needed for image layer caching).

See the blog post [here](https://www.tinfoilcipher.co.uk/2025/01/24/configuring-ecs-fargate-and-ecr-with-private-subnets/) for an in-depth breakdown of why all this is needed.

Provides options for provisioning the suitable endpoints for ECS Fargate 1.3 and earlier or 1.4 and later, as well as additional endpoints for Cloudwatch Logs, ECS telemetry and SSM should they be needed.

Provides two options for subnet and route table lookup, by providing IDs or looking up based on tags (see examples below). When looking up via tags any key: value pair of tags is suitable but they do need to exist in advance.

## tl;dr

```
terraform init
terraform apply
```

### Create endpoints, providing subnet and route table IDs

```bash
module "ecr_endpoints" {
    source                        = "tinfoilcipher/ecr-private-subnet-endpoints/aws"
    version                       = "x.x.x"
    vpc_id                        = "vpc-01234567890abcdef"
    private_subnet_ids            = ["subnet-44444444444444444", "subnet-55555555555555555", "subnet-666666666666666666"]
    private_route_table_ids       = ["rtb-00000000000000000", "rtb-11111111111111111", "rtb-abcdef33333333333"]
}
```

### Create endpoints, looking up subnets and route tables based on tags

```bash
module "ecr_endpoints" {
    source                        = "tinfoilcipher/ecr-private-subnet-endpoints/aws"
    version                       = "x.x.x"
    vpc_id                        = "vpc-01234567890abcdef"
    private_subnet_tag_key        = "tier"
    private_subnet_tag_value      = "private"
    private_route_table_tag_key   = "tier"
    private_route_table_tag_value = "private"
}
```

### Create additional endpoints for SSM, Telemetry, Logging
```bash
module "ecr_endpoints" {
    source                         = "tinfoilcipher/ecr-private-subnet-endpoints/aws"
    version                        = "x.x.x"
    vpc_id                         = "vpc-01234567890abcdef"
    private_subnet_ids             = ["subnet-44444444444444444", "subnet-55555555555555555", "subnet-666666666666666666"]
    private_route_table_ids        = ["rtb-00000000000000000", "rtb-11111111111111111", "rtb-abcdef33333333333"]
    configure_additional_endpoints = true
}
```
