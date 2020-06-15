# this Terraform code is to deploy an ec2-in3stance on aws mumbai region



### provider are used to manage,create & update ur infrastructure on cloud resources. 

provider "aws" {

  region = "ap-south-1"
}


#The general syntax for a Terraform resource is:

# resource "<PROVIDER>_<TYPE>" "<NAME>" {
#  [CONFIG …]
# }



resource "aws_instance" "myinstance" {
  ami           = "ami-0447a12f28fddb066"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}


