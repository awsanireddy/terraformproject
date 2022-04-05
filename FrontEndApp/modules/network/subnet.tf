# Create Subnet, Route tables, IGW, Nat Gateway , IGW, EIP for IGW and VPC_endpoint to connect to S3 and Dynamodb
data "aws_availability_zones" "available" {}

# Public subnets and private subnets
resource "aws_subnet" {
  count                   = length(var.private_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zones[count.index]
  cidr_block              = var.private_cidr_blocks[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, {Name = "${var.namespace}-subnet-private-${count.index + 1}"})
}

# Create Internet Gateway
resource "aws_internet_gateway" {
}
# Create Elastic IP for IGW
resource "aws_eip" "nat_eip" {

}
# Create NAT GateWay
resource "aws_nat_gateway" "nat_gw" {

 }
# Internet Access to Main Route Table and add nat gateway to each private subnet route table
resource "aws_route"{

}
# Associate Public Subnets to Main Route Table public and private
resource "aws_route_table_association" "public" {
}



 # for each of the private ranges, create a "private" route table.
resource "aws_route_table" "private_route_table" {

}
  # add a nat gateway to each private subnet's route table
resource "aws_route" "private_route" {

}

# Associate Private Subnets to private route tables
resource "aws_route_table_association" "private" {

}
