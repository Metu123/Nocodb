# ────────────────────────────────────────────────
# ✅ NocoDB Auto Setup (Render-Ready)
# Works with PostgreSQL/MySQL
# Node 22 required for latest NocoDB
# ────────────────────────────────────────────────
FROM node:22-alpine

WORKDIR /app

# Disable the pnpm restriction (causes npm install failure)
ENV NOCODB_SKIP_ONLY_ALLOW_PNPM=true

# Install NocoDB globally using npm
RUN npm install -g nocodb@latest --ignore-scripts

# Expose default port
EXPOSE 8080

# Environment variables (Render will inject)
# Example:
# DATABASE_URL=pg://username:password@hostname:5432/dbname
# NC_ADMIN_EMAIL=admin@example.com
# NC_ADMIN_PASSWORD=admin123
# NC_AUTH_JWT_SECRET=random-secret
# NC_PUBLIC_URL=https://your-app.onrender.com

# Healthcheck for Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s CMD wget -qO- http://localhost:8080/api/v1/db/meta || exit 1

# Start NocoDB
CMD echo "🚀 Launching NocoDB..." && npx nocodb
