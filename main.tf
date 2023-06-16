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


module "docdb" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-docdb.git"
  tags = var.tags

  for_each = var.docdb
  engine = each.value["engine"]
  engine_version = var.engine_version
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  subnet_ids = locals.db_subnet_ids
}