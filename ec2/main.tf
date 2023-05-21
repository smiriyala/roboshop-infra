#added local identity for image to be used.
data "aws_caller_identity" "current"{}

data "aws_ami" "ami" {
    most_recent = true
    name_regex = "devops-practice-with-ansible"
    #owners = ["973714476881"]
    owners = [data.aws_caller_identity.current.account_id]
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
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
            # "git clone https://github.com/smiriyala/roboshop-shell.git",
            # "cd roboshop-shell",
            # "sudo bash ${var.component}.sh"
            "ansible-pull -i localhost, -U https://github.com/smiriyala/roboshop-ansible.git roboshop.yml -e role_name-${var.component}"

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


#variabled declared to be used in this module
variable "component" {}
variable "instance_type" {}
variable "env" {
    default = "dev"
}
