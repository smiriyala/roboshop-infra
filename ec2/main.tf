data "aws_ami" "ami" {
    most_recent = true
    name_regex = "Centos-8-DevOps-Practice"
    owners = ["973714476881"]
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        name = var.component
    }

    # running command once instance is up
    provisioner "remote-exec" {

        connection {
          host = self.public_ip
          user = "centos"
          password = "DevOps321"
        }

        inline = [ 
            "git clone https://github.com/smiriyala/roboshop-shell.git",
            "cd roboshop-shell",
            "sudo bash ${var.component}.sh"

         ]
      
    }
  
}


#crating new security group as part of resource creation
resource "aws_security_group" "sg" {
    name = "${var.component}-${var.env}-sq"
    description = "Allows TLS inbound traffic"

    ingress = {
            description = "All"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }

    egress = {
        description = "All"
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