variable "region" {
    default = "ap-south-1"
}

variable "os_name" {
    default = "ami-03f4878755434977f"
}

variable "size" {
    default = "t2.micro"
}

variable "cidr_block_id" {
    default = "10.10.0.0/16" 
}

variable "subnet-1-cidr" {
    default = "10.10.1.0/24"
}