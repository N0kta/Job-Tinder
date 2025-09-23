#!/bin/bash
set -e

# Config
POSTGRES_CONTAINER="jobtinder-db"
POSTGRES_USER="postgres"
JOBTINDER_BACKUP="jobtinder_db.sql"
KEYCLOAK_BACKUP="keycloak_db.sql"

echo "=== Stopping all connections to databases ==="
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d postgres -c "
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname IN ('jobtinder_db', 'keycloak_db');"

echo "=== Dropping and recreating jobtinder_db ==="
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d postgres -c "DROP DATABASE IF EXISTS jobtinder_db;"
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE jobtinder_db;"
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d jobtinder_db -f /path/to/$JOBTINDER_BACKUP

echo "=== Dropping and recreating keycloak_db ==="
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d postgres -c "DROP DATABASE IF EXISTS keycloak_db;"
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE keycloak_db;"
docker exec -i $POSTGRES_CONTAINER psql -U $POSTGRES_USER -d keycloak_db -f /path/to/$KEYCLOAK_BACKUP

echo "=== Restore complete! ==="
