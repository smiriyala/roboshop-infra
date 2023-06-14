module "vpc" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-vpc.git"
  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
  tags = var.tags
  public_subnets = each.value["public_subnets"]
  private_subnets = each.value[ "private_subnets"]
}


##just help to see how the output would be...data
# NOTE: It doenst return anything as it need be configured OUTPUT file in resource module.
output "vpcData" {
  value = module.vpc.pu
  
}