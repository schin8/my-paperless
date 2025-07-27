#!/bin/bash

# Load environment variables from paperless.env
if [ -f "paperless.env" ]; then
  export $(grep -v '^#' paperless.env | xargs)
else
  echo "❌ paperless.env file not found!"
  exit 1
fi

# Use environment variables
DB_HOST="$PAPERLESS_DBHOST"
DB_PORT="$PAPERLESS_DBPORT"
DB_NAME="$PAPERLESS_DBNAME"
DB_USER="$PAPERLESS_DBUSER"
DB_PASS="$PAPERLESS_DBPASS"

# Export password to avoid interactive prompt
export PGPASSWORD="$DB_PASS"

# Attempt connection
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "\q"

# Check result
if [ $? -eq 0 ]; then
  echo "✅ PostgreSQL connection to $DB_NAME succeeded."
else
  echo "❌ Connection failed. Check host, port, credentials, or network settings."
fi

# Cleanup
unset PGPASSWORD
