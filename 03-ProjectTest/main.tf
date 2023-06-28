module "vpc_modules" {
    source ="./modules/aws_vpc"
    for_each = var.vpc_config
    vpc_cidr_block = each.value.vpc_cidr_block
    tags = each.value.tags
}
module "aws_subnet"{
    source = "./modules/aws_subnets"
    for_each = var.subnet_config
    vpc_id  = module.vpc_modules[each.value.vpc_name].vpc_id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone
    tags = each.value.tags
}  

module "internetGW_module"{
    source = "./modules/aws_internetGW"
    vpc_id =
    tags = 
}

module "route_table_module"{
    source = "./modules/aws_route_table"
    vpc_id = 
    gateway_id = 
    tags = ""
}

module "route_table_association"{
    source = "./modules/aws_route_table_associate"
    subnet_id = ""
    route_table_id =""
} 