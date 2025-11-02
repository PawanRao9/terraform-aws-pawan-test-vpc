resource "aws_vpc" "main" {
    cidr_block = var.vpc_config.cidr_block


    tags = {
      name = var.vpc_config.name
    }
  
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id
    for_each = var.subnet_config # this will set key={cidr, az} each.key each.value


    cidr_block = each.value.cidr_block
    availability_zone = each.value.az

    tags = {
      "name" = each.key  # what ever the name of the subnet will be set as the tag
    }
  
}


locals {
  public_subnets = {
    # key={} if public is true in subnet_cofig
    for key , congig in var.subnet_config : key => config if config.public
  }
  private_subnets = {
    # key={} if public is true in subnet_cofig
    for key , congig in var.subnet_config : key => config if !config.public
  }
}
# if there is atleast one public subnet
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    count = length(local.public_subnets) > 0 ? 1 : 0
}


#routing table 
resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
    count = length(local.public_subnets) > 0 ? 1 : 0
    
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
}

resource "aws_route_table_association" "main" {
    for_each = local.public_subnets


    subnet_id = aws_subnet.main[each.key].id
    route_table_id = aws_route_table.main[0].id
  
}