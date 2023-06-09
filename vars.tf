#Variables for docdb
variable "env" {}
variable "vpc" {}
variable "tags" {}
variable "default_route_table" {}
variable "default_vpc_id" {}
variable "docdb" {}


#Variable for RDS-aurora mysql
variable "rds" {}
variable "elasticache" {}

##rabbitmq
variable "rabbitmq" {}


##alb
variable "alb" {}

#APPS
variable "apps" {}
variable "bastion_cidr" {}

variable "dns_domain" {}

variable "monitoring_nodes" {}