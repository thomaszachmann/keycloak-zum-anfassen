terraform {
  required_version = ">= 1.17.0"
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.10.0"
    }
  }
}

# Anmeldung als Service-Account des Clients automation im Realm lab (Tag 13)
provider "keycloak" {
  url           = var.kc_url
  realm         = "lab"
  client_id     = "automation"
  client_secret = var.client_secret
}
