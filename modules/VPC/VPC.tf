# create a VPC
resource "aws_vpc" "vpc_main" {
  cidr_block        = var.vpc_cidr
  instance_tenancy  = "default"

  tags = {
    Name = "${var.name_prefix}-VPC"
  }
}

# create a Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "${var.name_prefix}-IGW"
  }
}

# access to the list of AWS Availability Zones within the region configured in the provider
data "aws_availability_zones" "az_available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.public_subnets[count.index]
  # ensure subnets are deployed on different AZ
  availability_zone = data.aws_availability_zones.az_available.names[count.index]
  depends_on        = [aws_vpc.vpc_main]

  tags = {
    subnet_type = "public"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.private_subnets[count.index]
  # ensure subnets are deployed on different AZ
  availability_zone = data.aws_availability_zones.az_available.names[count.index]
  depends_on        = [aws_vpc.vpc_main]

  tags = {
    subnet_type = "private"
  }
}

# create a route table for Internet Gateway and public subnet
resource "aws_route_table" "igw-public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name_prefix}-public-route"
  }
}

# create a route table for private subnet
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "${var.name_prefix}-private-route"
  }
}


# route associations
# associate the route table of IGW with public subnet
resource "aws_route_table_association" "main-public-igw" {
  count           = length(var.public_subnets)
  subnet_id       = element(aws_subnet.public_subnet[*].id,count.index)
  route_table_id  = aws_route_table.igw-public.id
}

resource "aws_route_table_association" "main-private" {
  count           = length(var.private_subnets)
  subnet_id       = element(aws_subnet.private_subnet[*].id,count.index)
  route_table_id  = aws_route_table.private_route.id
}