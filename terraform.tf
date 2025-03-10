terraform {

  required_version = ">= 1.10.0"

  required_providers {
    temporalcloud = {
      source  = "temporalio/temporalcloud"
      version = "~> 0.6.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.6"
    }
  }

  backend "local" {}
}

provider "temporalcloud" {
  # Also can be set by environment variable `TEMPORAL_CLOUD_API_KEY`
  api_key = var.temporal_cloud_api_key

  endpoint       = "saas-api.tmprl.cloud:443"
  allow_insecure = false

  # Also can be set by environment variable `TEMPORAL_CLOUD_ALLOWED_ACCOUNT_ID`
  allowed_account_id = var.temporal_cloud_allowed_account_id
}

provider "tls" {}