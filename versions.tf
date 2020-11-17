# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.13.2"
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "2.33.0"
    }
  }
}


