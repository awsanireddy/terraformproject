variable "namespace" {
}
variable "vpc_id" {
}
variable "billing-product" {
}
variable "billing-component" {
}
variable "public_subnet_id_list" {
  type        = "list"
  description = "List of subnet ids"
}

variable "private_subnet_id_list" {
  type        = "list"
  description = "List of subnet ids"
}
variable "security_group_id"{
  
}
