variable "vpc_config" {
    description = "to get the CIDR and the Name of VPC from user "
    type = object({
      cidr_block = string
      name       = string 
    })
    validation {
      condition = can(cidrnetmask(var.vpc_config.cidr_block))
      error_message = "invalid cidr format - ${var.vpc_config.cidr_block}"
    }
  
}

variable "subnet_config" {
    description = "Get cidr and availability zones for the subnets "

    type = map(object({
      cidr_block = string
      az         = string
      public = optional(bool, false)
      
    }))  
    validation {
      condition = alltrue([for config in var.subnet_config: can(cidrnetmask(config.cidr_block))]) # this block will check weather the user provided the corrcet values. and it will store it in a list for all the subnets that are created
      error_message = "invalid cidr format - ${var.vpc_config.subnet_config}"
    }

}