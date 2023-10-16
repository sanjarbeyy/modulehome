resource "aws_vpc" "testvpc" {
  cidr_block = var.vpc_cidr 
}

variable "vpc_cidr" {
  type = string
}

output "vpc_id" {
  value = aws_vpc.testvpc.id
}