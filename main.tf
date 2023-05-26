module "ec2" {
    for_each = var.instances
    source = "./ec2"
    component = each.value["name"]
    instance_type = each.value["type"]
    #not understand which var file is being picked up, ec2 vars.tf or roboshop-infra vars.tf
    env = var.env
  
}