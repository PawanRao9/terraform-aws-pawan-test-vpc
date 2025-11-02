to create a complete config with this module 

USAGE

module "vpc" {
    source = "./module/vpc"

    vpc_config = {
      cidr_block = "10.0.0.0/16"
      name = "my-test-vpc"
    }

    subnet_config = {
      # format = key{cidr, az}
      public_subnets = {
        cidr_block = "10.0.0.0/16"
        az         = "eu-north-1a"
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

