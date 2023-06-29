module "vpc" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-vpc.git"
  for_each = var.vpc
  vpc_cidr = each.value[ "vpc_cidr" ]
  tags = var.tags
  public_subnets = each.value[ "public_subnets" ]
  private_subnets = each.value[ "private_subnets"]
  default_route_table = var.default_route_table
  default_vpc_id = var.default_vpc_id
}


##just help to see how the output would be...data
# NOTE: It doenst return anything as it need be configured OUTPUT file in resource module.

/* output "vpcdata" {
  value = module.vpc
  
} */


#Creating DocumentDB with cluster'
module "docdb" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-docdb.git"
  tags = var.tags
  subnet_ids = local.db_subnet_ids
  vpc_id  = module.vpc["main"].vpc_id

  for_each = var.docdb
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
  allow_subnets = lookup(local.subnet_cidr, each.value["allow_subnets"], null)

}


#Creating RDS aurora 5.7 (Mysql) db
module "rds" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-rds.git"
  tags = var.tags
  subnet_ids = local.db_subnet_ids

  for_each = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  instance_class          = each.value["instance_class"]
  no_of_instances         = each.value["no_of_instances"]
  #skip_final_snapshot     = each.value["skip_final_snapshot"]
  
}

#Creating ELASTIC CACHE for user login check service
module "elasticache" {
  env                     = var.env
  source                  = "git::https://github.com/smiriyala/tf-module-elasticache.git"
  tags                    = var.tags
  subnet_ids              = local.db_subnet_ids

  for_each                = var.elasticache
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  nun_cache_nodes         = each.value["nun_cache_nodes"]
  node_type               = each.value["node_type"]
  vpc_id                  = module.vpc["main"].vpc_id
  allow_subnets           = lookup(local.subnet_cidr, each.value["allow_subnets"], null)
  
}

#RabbitMQ - rathar than using aws service, we are creating EC2 Instance as Service doesnt 
# Support to create cluster environment?
module "rabbitmq" {
  env                     = var.env
  source                  = "git::https://github.com/smiriyala/tf-module-rabbitmq.git"
  tags                    = var.tags
  subnet_ids              = local.db_subnet_ids

  for_each                = var.rabbitmq
  instance_type    = each.value["instance_type"]
  
}

#Module Load Balancer
module "alb" {
  env                     = var.env
  source                  = "git::https://github.com/smiriyala/tf-module-alb.git"
  tags                    = var.tags

  # VPC id required to create a security group
  vpc_id                  = module.vpc["main"].vpc_id

  for_each  = var.alb
  name = each.value["name"]
  internal = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null)
  allow_cidr = each.value["allow_cidr"]
  
}


#Module APP Server for Load Balancer
module "app" {
  env                     = var.env
  source                  = "git::https://github.com/smiriyala/tf-module-app.git"
  tags                    = var.tags
  bastion_cidr            = var.bastion_cidr
  vpc_id                  = module.vpc["main"].vpc_id
  dns_domain              = var.dns_domain

  for_each  = var.apps
  component = each.value["component"]
  instance_type = each.value["instance_type"]
  desired_capacity   = each.value["desired_capacity"]
  max_size           = each.value["max_size"]
  min_size           = each.value["min_size"]
  subnets           = lookup(local.subnet_ids, each.value["subnet_name"], null)
  port = each.value["port"]
  allow_app_to = lookup(local.subnet_cidr, each.value["allow_app_to"], null)
  alb_dns_name = lookup(lookup(lookup(module.alb, each.value["alb"], null),"alb", null), "dns_name", null)
  listener_arn = lookup(lookup(lookup(module.alb, each.value["alb"], null),"listener", null), "arn", null)
  listener_priority = each.value["listener_priority"]
  parameters = each.value["parameters"]

  
}

##to debug to check VPC id is comming out or not?
# it gives out entire VPC module data out. 

/* output "vpc"{
  value = module.vpc
} */