#added local identity for image to be used.

# this is moved to data.tf file:)
/* data "aws_caller_identity" "current"{}

data "aws_ami" "ami" {
    most_recent = true
    name_regex = "devops-practice-with-ansible"
    #owners = ["973714476881"]
    owners = [data.aws_caller_identity.current.account_id]
} */

resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    #iam_instance_profile = aws_iam_instance_profile.profile.name
    tags = {
        Name = var.component
    }
}


resource "null_resource" "provisioner" {

    # running command once instance is up
    provisioner "remote-exec" {
        connection {
          host = aws_instance.ec2.public_ip
          user = "centos"
          password = "DevOps321"
        }
        inline = [ 
          /* "git clone https://github.com/smiriyala/roboshop-shell.git",
          "cd roboshop-shell",
          "sudo bash ${var.component}.sh" */
          "ansible-pull -i localhost, -U https://github.com/smiriyala/roboshop-ansible.git roboshop.yml -e role_name=${var.component}"

         ]
      
    }
}

#crating new security group as part of resource creation
resource "aws_security_group" "sg" {
    name = "${var.component}-${var.env}-sq"
    description = "Allows TLS inbound traffic"

    ingress {
            description = "ALL"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }

    egress {
        description = "ALL"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "${var.component}-${var.env}-sq"
    }
  
}


# route53 entries for the modules
resource "aws_route53_record" "record" {
  zone_id ="Z034160419BHTFKQ5CIGO"
  name = "${var.component}-dev.devopsforyou.online"
  type = "A"
  ttl = 30
  records = [aws_instance.ec2.private_ip]
}

/* 
##creaeting IAM policy
resource "aws_iam_policy" "ssm-policy" {

  name        = "${var.env}-${var.component}-ssm"
  path        = "/"
  description = "${var.env}-${var.component}-ssm"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": "arn:aws:ssm:us-east-1:934235628328:parameter/${var.env}.${var.component}*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "ssm:DescribeParameters",
        "Resource": "*"
      }
    ]
  })
}

##Createing IAM role:
resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

#Attaching Instance Profile: Instance profile, you cant attach role directly.
resource "aws_iam_instance_profile" "profile" {
  name = "${var.env}-${var.component}-role"
  role = aws_iam_role.role.name
}

## Policy attachement, 
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ssm-policy.arn
} */


##This codd moved to vars.tf file in ec2
/* #variabled declared to be used in this module
variable "component" {}
variable "instance_type" {}
variable "env" {
    default = "dev"
} */
