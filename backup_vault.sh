#!/bin/bash

# Configuration
BACKUP_DIR="<YOUR_BACKUP_DIRECTORY>"  # Replace with the directory where backups will be stored
DATE=$(date +%F)
EXPORT_FILE="$BACKUP_DIR/vault_backup_$DATE.json"

# OAuth2 Credentials
CLIENT_ID="<YOUR_CLIENT_ID>"  # Replace with your Vaultwarden client_id
CLIENT_SECRET="<YOUR_CLIENT_SECRET>"  # Replace with your Vaultwarden client_secret
SCOPE="api"
GRANT_TYPE="client_credentials"

# Vaultwarden URL
VAULTWARDEN_URL="<YOUR_VAULTWARDEN_URL>"  # Replace with the base URL of your Vaultwarden server

# Device Identifiers
DEVICE_IDENTIFIER="<YOUR_DEVICE_IDENTIFIER>"  # Replace with a unique device identifier
DEVICE_NAME="<YOUR_DEVICE_NAME>"  # Replace with a human-readable device name
DEVICE_TYPE="server"  # Change if the device type differs (e.g., "desktop", "mobile")

# Create backup directory (if it doesn't exist)
mkdir -p "$BACKUP_DIR"

# Obtain token via API
TOKEN=$(curl -s -X POST "$VAULTWARDEN_URL/identity/connect/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=$GRANT_TYPE&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&scope=$SCOPE&device_identifier=$DEVICE_IDENTIFIER&device_name=$DEVICE_NAME&device_type=$DEVICE_TYPE" \
    | jq -r '.access_token')

# Perform export of the vault
curl -s -X GET "$VAULTWARDEN_URL/api/ciphers/export" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -o "$EXPORT_FILE"

# Secure the backup file
chmod 600 "$EXPORT_FILE"

# Delete backups older than 30 days
find "$BACKUP_DIR" -type f -name "vault_backup_*.json" -mtime +30 -exec rm {} \;
