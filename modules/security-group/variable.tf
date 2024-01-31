variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the security group"
  default     = {}
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group for ElastiCache"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID for the ElastiCache security group"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of ingress rules for the security group"
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of egress rules for the security group"
}