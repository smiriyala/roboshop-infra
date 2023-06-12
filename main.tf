module "vpc" {
  env = var.env
  source = "git::https://github.com/smiriyala/tf-module-vpc.git"
  for_each = var.vpc
  tags = var.tags
  vpc_cidr = each.value["vpc_cidr"]
}