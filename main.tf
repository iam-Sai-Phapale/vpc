provider "aws" {
    region = var.region
}

resource "aws_instance" "web" {
  ami           = var.os_name
  instance_type = var.size
  subnet_id = aws_subnet.demo_subnet.id
  vpc_security_group_ids = [ aws_security_group.demo-vpc-sg.id]

  tags = {
    Name = "vpc-example"
  }
}


//cerate vpc
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.cidr_block_id
}

//create subnet
resource "aws_subnet" "demo_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.subnet-1-cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "demo subnet"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo igw"
  }
}

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

//asscoaite subnet 
resource "aws_route_table_association" "demo-rt_assocaition" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

resource "aws_security_group" "demo-vpc-sg" {
    name = "demo-vpc-sg"
    vpc_id = aws_vpc.demo_vpc.id

    ingress {
        description = "TLS from vpc"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      Name = "demo-vpc-sg"
    }

}






