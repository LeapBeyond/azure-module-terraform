# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

locals {
  # This is used to divide the vnet subnet IP range into (number of AZ) subranges
  subnet_count = 4
}

variable "region" {
  description = "Define the region where resources are created"
  type        = string
}

variable tags {
  description = "set of common tags to apply to resources"
  type        = map(string)
}

variable vnet_cidr {
  description = "cidr block to allocate to the vnet - a /24 block is recommended"
  type        = string
}

variable vnet_name {
  description = "a name to associate with the vnet and other resources, ideally with no spaces"
  type        = string
}

variable ssh_inbound {
  description = "list of cidr blocks that are allowed to SSH into the instance"
  type        = string
}
