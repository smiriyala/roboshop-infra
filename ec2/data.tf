data "aws_caller_identity" "current"{}

data "aws_ami" "ami" {
    most_recent = true
    name_regex = "devops-practice-with-ansible"
    #owners = ["973714476881"]
    owners = [data.aws_caller_identity.current.account_id]
}