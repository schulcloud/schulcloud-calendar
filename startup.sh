PGPASSWORD=$DB_PASSWORD psql -U node -c "CREATE DATABASE $NAMESPACE"
PGPASSWORD=$DB_PASSWORD psql -U node -d $NAMESPACE -a -f schema.sql

npm start