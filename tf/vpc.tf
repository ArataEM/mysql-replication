resource "aws_vpc" "mysql-repl" {
  cidr_block = "10.2.0.0/16"
  enable_dns_hostnames = true
  
  tags = {
    Name = "mysql-repl"
  }
}

resource "aws_subnet" "mysql-repl-public1" {
  vpc_id     = aws_vpc.mysql-repl.id
  cidr_block = "10.2.1.0/24"
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "mysql-repl-public1"
  }
}

resource "aws_internet_gateway" "mysql-repl-igw" {
  vpc_id = aws_vpc.mysql-repl.id

  tags = {
    Name = "mysql-repl-igw"
  }
}

resource "aws_route_table" "mysql-repl-public-rt" {
  vpc_id = aws_vpc.mysql-repl.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mysql-repl-igw.id
  }

  tags = {
    Name = "mysql-repl-public-rt"
  }
}

resource "aws_route_table_association" "mysql-repl-public1" {
  subnet_id      = aws_subnet.mysql-repl-public1.id
  route_table_id = aws_route_table.mysql-repl-public-rt.id
}
