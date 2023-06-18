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


#Creating DocumentDB with cluster
module "docdb" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-docdb.git"
  tags = var.tags
  subnet_ids = local.db_subnet_ids

  for_each = var.docdb
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]

  
}


#Creating RDS aurora 5.7 (Mysql) db
/* module "rds" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-rds.git"
  tags = var.tags
  subnet_ids = local.db_subnet_ids

  for_each = var.rds
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]

  
} */