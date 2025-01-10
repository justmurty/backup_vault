# Backup Vaultwarden Script

This repository contains a Bash script for automating backups of a Vaultwarden (Bitwarden) server. The script retrieves a backup of the Vaultwarden data and saves it securely to a specified directory. It is designed to work with the Vaultwarden API and supports token-based authentication.

## Features
- Automatically retrieves a backup from Vaultwarden.
- Stores backups in a specified directory.
- Removes backups older than 30 days.
- Secures the backup file with restricted permissions.
- Fully automated execution via cron.

## Requirements

### Software Dependencies
- Bash shell
- `curl` for making HTTP requests
- `jq` for parsing JSON

### Vaultwarden Configuration
- A valid Vaultwarden API `client_id` and `client_secret`.
- Vaultwarden server URL accessible from the machine running the script.
- The Vaultwarden server must have API support enabled.

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/vaultwarden-backup.git
   cd vaultwarden-backup
   ```

2. Make the script executable:
   ```bash
   chmod +x backup_vault.sh
   ```

3. Update the script with your configuration:
   - `BACKUP_DIR`: The directory where backups will be stored.
   - `CLIENT_ID`, `CLIENT_SECRET`: Your Vaultwarden API credentials.
   - `VAULTWARDEN_URL`: The URL of your Vaultwarden server.

4. Test the script manually:
   ```bash
   ./backup_vault.sh
   ```

5. Set up automated backups using cron:
   ```bash
   crontab -e
   ```
   Add the following line to schedule weekly backups every Sunday at 2:00 AM:
   ```bash
   0 2 * * 0 /path/to/backup_vault.sh >> /var/log/backup_vault.log 2>&1
   ```

## Usage
### Running the Script Manually
Execute the script directly:
```bash
./backup_vault.sh
```

### Automating Backups
Use the cron job to automate the execution. Logs will be written to `/var/log/backup_vault.log` if configured as shown above.

## Script Details
### Variables
- `BACKUP_DIR`: Directory for storing backup files.
- `DATE`: Current date, used for naming backup files.
- `EXPORT_FILE`: Path to the backup file to be created.
- `CLIENT_ID`, `CLIENT_SECRET`: OAuth2 credentials for the Vaultwarden API.
- `VAULTWARDEN_URL`: Base URL of the Vaultwarden server.
- `DEVICE_IDENTIFIER`, `DEVICE_NAME`, `DEVICE_TYPE`: Identifiers for the backup device.

### Backup Process
1. Generate an API token using the provided credentials.
2. Retrieve the backup from Vaultwarden using the API.
3. Save the backup file to the specified directory with restricted permissions.
4. Delete old backups (older than 30 days).

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing
Feel free to open issues or submit pull requests for improvements or bug fixes.

## Acknowledgments
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden) for providing the lightweight Bitwarden server.
- Community contributions for inspiration on API usage.

