# ────────────────────────────────────────────────
# ✅ NocoDB Render Auto Backend
# Works with PostgreSQL or MySQL
# Automatically connects via environment variables
# ────────────────────────────────────────────────
FROM node:20-alpine

WORKDIR /app

# Install NocoDB globally
RUN npm install -g nocodb@latest

# Expose default NocoDB port
EXPOSE 8080

# Environment variables for NocoDB
ENV NC_DB="pg://$DATABASE_USERNAME:$DATABASE_PASSWORD@$DATABASE_HOST:$DATABASE_PORT/$DATABASE_NAME?ssl=true"
ENV NC_AUTH_JWT_SECRET="supersecretjwtkey"

# Healthcheck for Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s CMD wget -qO- http://localhost:8080/api/v1/db/meta || exit 1

# Start NocoDB
CMD echo "🚀 Launching NocoDB..." && npx nocodb
