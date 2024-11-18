### 
variable "project_name" {}
variable "region" {}
variable "ssm_vpc_cidr" {

}
variable "default_tags" {}
variable "ssm_vpc_id" {}

variable "ssm_subnet_database_1a" {}
variable "ssm_subnet_private_1a" {}
variable "ssm_subnet_public_1a" {}
variable "ssm_subnet_database_1b" {}
variable "ssm_subnet_private_1b" {}
variable "ssm_subnet_public_1b" {}
variable "ssm_subnet_database_1c" {}
variable "ssm_subnet_private_1c" {}
variable "ssm_subnet_public_1c" {}

## Load Balancer ###

variable "lb_internal" {}
variable "lb_type" {}


## ECS variables

variable "nodes_ami" {}

variable "node_instance_type" {}

variable "node_volume_size" {}

variable "node_volume_type" {}

variable "cluster_on_demand_min_size" {}
variable "cluster_on_demand_max_size" {}
variable "cluster_on_demand_desired_size" {}


variable "cluster_spots_min_size" {}
variable "cluster_spots_max_size" {}
variable "cluster_spots_desired_size" {}

variable "spot_max_price" {
  type        = string
  description = "description"
}
  