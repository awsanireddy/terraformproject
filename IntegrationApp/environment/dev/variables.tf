# All the variables passed into modules are defined here. Few example variables
variable "namespace"{
  description = "Namespace used to create the environment. Naming convention is product-environment"
}

variable "aws_region"{
  description = "The region to run terraform changes"
  default = "us-east-1"
}

variable "public_cidr_block"{
  description = "Public CIDR block to create subnets"
  type = list(string)
}

variable "private_cidr_block"{
  description = "Private CIDR block to create subnets"
  type = list(string)
}
