variable "namespace"{

}
variable "public_cidr_block"{
  description = "Public CIDR block to create subnets"
  type = list(string)
}

variable "private_cidr_block"{
  type = list(string)
}
variable "vpc_cidr"{

}
variable "service_name"{
  
}
