resource "aws_ssm_parameter" "parameters" {
    count = length(var.parameters)
    name = var.parameters[count.index].name
    type = var.parameters[count.index].type
    value = var.parameters[count.index].value
    overwrite = true

    /* lifecycle {
        ignore_changes = [
        value,
        ]
    } */
}

resource "aws_ssm_parameter" "secrets" {
  count = length(var.secrets)
  name = var.secrets[count.index].name
  type = var.secrets[count.index].type
  value = var.secrets[count.index].value
  overwrite = true

  /* lifecycle {
    ignore_changes = [
      value,
    ]
  } */
}

resource "aws_ssm_parameter" "jenkins_user" {
  name = "jenkins.user"
  type = "String"
  value = "admin"
  overwrite = true

}

resource "aws_ssm_parameter" "jenkins_pass" {
  name = "jenkins.pass"
  type = "SecureString"
  value = "admin123"
  overwrite = true

}

#This variable values are reading from main.tfvars or whatever you used to pass
# while executing this state file in terraform apply
variable "parameters" {}
variable "secrets"{}

provider "aws" {
    region = "us-east-1"
}