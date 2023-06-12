module "vpc" {
  env = var.env
  tags = var.tags
  source = "git::https://github.com/smiriyala/tf-module-vpc.git"
  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
}