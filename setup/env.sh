# setup/env.sh – zu Beginn jedes Trainingstags einlesen: source ~/kc-lab/setup/env.sh
export LAB="$HOME/kc-lab"
export VM_IP="${VM_IP:-$(hostname -I | awk '{print $1}')}"   # erste IP der VM
export KC_URL="http://kc.$VM_IP.sslip.io:8080"               # Keycloak, ab Tag 12 https
export NOTES_URL="http://notes.$VM_IP.sslip.io:4180"         # notes hinter oauth2-proxy
export REALM=lab

# kcadm.sh im Keycloak-Container (ab Tag 1); Anmeldung mit kclogin
kcadm() {
  docker compose -f "$LAB/keycloak/compose.yaml" exec -T keycloak \
    /opt/keycloak/bin/kcadm.sh "$@"
}
kclogin() {
  kcadm config credentials --server http://localhost:8080 --realm master \
    --user "${KC_ADMIN_USER:-kcadmin}" --password "${KC_ADMIN_PW:-lab-admin-pw-123}"
}

# Access Token für einen Benutzer des Realms lab holen (ab Tag 3)
token() {
  curl -s -d grant_type=password -d client_id=notes-cli \
    -d client_secret=lab-client-secret-123 -d username="${1:-anna}" \
    -d password="${2:-lab-user-pw-123}" -d scope=openid \
    "$KC_URL/realms/$REALM/protocol/openid-connect/token" | jq -r .access_token
}

# Payload eines JWT lesbar machen: jwt "$TOKEN"
jwt() {
  echo "$1" | jq -R 'split(".")[1] | gsub("-";"+") | gsub("_";"/") | @base64d | fromjson'
}

[ -f "$LAB/setup/vms.env" ] && . "$LAB/setup/vms.env"
true
