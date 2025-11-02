# terraform-aws-vpc

## overview

This Terraform moddule create an AWS VPC with a given CIDR block , it also create multiple subnets (public and private), and for public subnets, it sets up an internet gateway (IGW) and appropreate route table

# features 

- creates a vpc with a specific CIDR block
- create public and private subnets
- create an route gateway (igw) for public subnet
- sets up route table for public subnet

## usage 

```
module "vpc" {
    source = "./module/vpc"

    vpc_config = {
      cidr_block = "10.0.0.0/16"
      name = "your-vpc-name"
    }

    subnet_config = {
     
      public_subnets = {
        cidr_block = "10.0.0.0/16"
        az         = "eu-north-1a"
        # to set the subnet as public, defalut is private
        public     = true
      } 

      private_subnet ={
        cidr_block = "10.0.2.0/16"
        az         = "eu-north-1a"
      }
      private_subnet ={
        cidr_block = "10.0.3.0/16"
        az         = "eu-north-1b"
      }
    }
  
}



```