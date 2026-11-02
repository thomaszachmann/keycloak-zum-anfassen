# Berichte für notes: Rolle, Gruppe, Client und ein Benutzer – alles als Code
data "keycloak_realm" "lab" {
  realm = "lab"
}

resource "keycloak_role" "berichte" {
  realm_id    = data.keycloak_realm.lab.id
  name        = "notes-berichte"
  description = "Darf Berichte aus notes abrufen"
}

resource "keycloak_group" "berichte" {
  realm_id = data.keycloak_realm.lab.id
  name     = "berichte"
}

resource "keycloak_group_roles" "berichte" {
  realm_id = data.keycloak_realm.lab.id
  group_id = keycloak_group.berichte.id
  role_ids = [keycloak_role.berichte.id]
}

resource "keycloak_openid_client" "reports" {
  realm_id                 = data.keycloak_realm.lab.id
  client_id                = "notes-reports"
  name                     = "notes Berichte"
  access_type              = "CONFIDENTIAL"
  client_secret            = "lab-client-secret-123"
  service_accounts_enabled = true
  standard_flow_enabled    = false
}

resource "keycloak_user" "theo" {
  realm_id       = data.keycloak_realm.lab.id
  username       = "theo"
  email          = "theo@notes.lab"
  email_verified = true
  first_name     = "Theo"
  last_name      = "Form"

  initial_password {
    value     = "lab-user-pw-theo"
    temporary = false
  }
}

resource "keycloak_user_groups" "theo" {
  realm_id  = data.keycloak_realm.lab.id
  user_id   = keycloak_user.theo.id
  group_ids = [keycloak_group.berichte.id]
}

output "reports_client_uuid" {
  value = keycloak_openid_client.reports.id
}
