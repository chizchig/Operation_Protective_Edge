# Function to generate a random string
resource "random_string" "vpc_name" {
  length = 8
  special = false
}

# vpc configuration
resource "aws_vpc" "vpc" {
  cidr_block = cidrsubnet("10.0.0.0/8", 4, 0 )
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "InternetGateway-${random_string.vpc_name.result}"
  }
}

# Subnet Configuration
resource "aws_subnet" "subnets" {
  for_each = toset(local.generate_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = "us-east-1a" # Change as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-${each.key}-${random_string.vpc_name.result}"
  }
}

# Route Table Configuration
resource "aws_route_table" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = "MainRouteTable-${random_string.vpc_name.result}"
  }
}

# Associate Route Table with Subnets
resource "aws_route_table_association" "subnet_associations" {
  for_each = aws_subnet.subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.main.id
}

# Create Route for Internet Gateway
resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}