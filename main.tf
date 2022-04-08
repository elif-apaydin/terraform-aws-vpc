terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.3"
    }
  }
}

provider "aws" {
  region  = var.region
}

data "aws_availability_zones" "available" {
		  state = "available"
		}

resource "aws_vpc" "VPC" {
  cidr_block              = var.vpc_cidr
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags                    = {
    Name                  = var.app_tags
    APP_NAME              = var.app_tags
  }
}

resource "aws_subnet" "PublicSubnet1" {
  cidr_block              = var.subnet1
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = {
    Name                  = "${var.app_tags} Public Subnet AZ A"
    APP_NAME              = var.app_tags
  }
}

resource "aws_subnet" "PublicSubnet2" {
  cidr_block              = var.subnet2
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.VPC.id
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags                    = {
    Name                  = "${var.app_tags} Public Subnet AZ B"
    APP_NAME              = var.app_tags
  }
}

resource "aws_route_table" "RouteTablePublic" {
  vpc_id                  = aws_vpc.VPC.id
  depends_on              = [ aws_internet_gateway.Igw ]

  tags = {
    Name                  = "${var.app_tags} Public Route Table"
    APP_NAME              = var.app_tags
  }

  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = aws_internet_gateway.Igw.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePublic0" {
  subnet_id               = aws_subnet.PublicSubnet1.id
  route_table_id          = aws_route_table.RouteTablePublic.id
}
resource "aws_route_table_association" "AssociationForRouteTablePublic1" {
  subnet_id               = aws_subnet.PublicSubnet2.id
  route_table_id          = aws_route_table.RouteTablePublic.id
}

resource "aws_internet_gateway" "Igw" {
  vpc_id                  = aws_vpc.VPC.id
  tags                    = {
    Name                  = var.app_tags
    APP_NAME              = var.app_tags
  }
}
