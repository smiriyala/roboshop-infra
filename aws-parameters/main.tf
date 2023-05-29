resource "aws_ssm_parameter" "parameters" {
    count = length(var.parameters)
    name = var.parameters[count.index].name
    type = var.parameters[count.index].type
    value = var.parameters[count.index].value
}

#This variable values are reading from main.tfvars or whatever you used to pass
# while executing this state file in terraform apply
variable "parameters" {}