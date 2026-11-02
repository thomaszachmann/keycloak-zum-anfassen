variable "kc_url" {
  description = "Adresse von Keycloak, z. B. https://kc.192.168.64.5.sslip.io"
  type        = string
}

variable "client_secret" {
  description = "Secret des Clients automation"
  type        = string
  sensitive   = true
}
