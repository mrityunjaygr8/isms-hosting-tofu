variable "passphrase" {
  # Change passphrase to be at least 16 characters long:
  default = "correct-horse-battery-staple"
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }

  encryption {
    ## Step 1: Add the desired key provider:
    key_provider "pbkdf2" "mykey" {
      passphrase = var.passphrase
    }
    ## Step 2: Set up your encryption method:
    method "aes_gcm" "new_method" {
      keys = key_provider.pbkdf2.mykey
    }

    state {
      ## Step 3: Link the desired encryption method:
      method = method.aes_gcm.new_method

      ## Step 4: Run "tofu apply".

      ## Step 5: Consider adding the "enforced" option:
      # enforced = true
    }

    ## Step 6: Repeat steps 3-5 for plan{} if needed.
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "f2ab75cb-58d3-4fd2-970b-7a1f034b4870"
}

module "isms" {
  cloud_init_file = base64encode(file("${path.module}/../../extra/cloud_init.yaml"))
  location = var.location
  resource_group_name = var.resource_group_name
  source = "${path.module}/../../modules/isms"
  ssh_public_key = file("${path.module}/../../extra/id_rsa.pub")
  tags = var.tags
}

