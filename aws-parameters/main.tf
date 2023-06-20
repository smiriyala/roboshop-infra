terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_ssm_parameter" "parameters" {
    count = length(var.parameters)
    name = var.parameters[count.index].name
    type = var.parameters[count.index].type
    value = var.parameters[count.index].value
}

resource "aws_ssm_parameter" "secrets" {
    count = length(var.secrets)
    name = var.secrets[count.index].name
    type = var.secrets[count.index].type
    value = var.secrets[count.index].value
}

#This variable values are reading from main.tfvars or whatever you used to pass
# while executing this state file in terraform apply
variable "parameters" {}
variable "secrets"{}