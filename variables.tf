variable "service_name" {
    description = "Service Name"
    type        = string
    default     = "ecs"
}

variable "vpc_id" {
    description = "VPC to deploy Endpoints in to"
    type        = string
}

variable "private_subnet_tag_key" {
    description = "Metadata key for Private Subnets"
    type        = string
    default     = ""
}

variable "private_subnet_tag_value" {
    description = "Metadata value for Private Subnets"
    type        = string
    default     = ""
}

variable "private_route_table_tag_key" {
    description = "Metadata key for Private Route Tables"
    type        = string
    default     = ""
}

variable "private_route_table_tag_value" {
    description = "Metadata value for Private Route Tables"
    type        = string
    default     = ""
}

variable "private_subnet_ids" {
    description = "List of Private Subnet IDs"
    type        = list(string)
    default     = [""]
}

variable "private_route_table_ids" {
    description = "List of Private Route Table IDs"
    type        = list(string)
    default     = [""]
}

variable "fargate_version" {
    description = "ECS Fargate Version"
    type        = string
    default     = "1.4"
    validation {
        condition = contains(["1.3", "1.4"], var.fargate_version)
        error_message = "Invalid Fargate version provided."
    }
}

variable "configure_additional_endpoints" {
    description = "Configure Additional VPC Endpoints for ECS Telemetry, SSM, Cloudwatch"
    type        = bool
    default     = false
}
