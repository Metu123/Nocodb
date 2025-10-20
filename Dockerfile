# ────────────────────────────────────────────────
# ✅ NocoDB Render Auto Setup (PostgreSQL Ready)
# Compatible with Node 22+
# ────────────────────────────────────────────────
FROM node:22-alpine

WORKDIR /app

# Skip pnpm enforcement that breaks npm installs
ENV NOCODB_SKIP_ONLY_ALLOW_PNPM=true

# Install NocoDB globally
RUN npm install -g nocodb@latest --ignore-scripts

# Expose default port
EXPOSE 8080

# Healthcheck (Render requirement)
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s CMD wget -qO- http://localhost:8080 || exit 1

# Start NocoDB directly (not via npx)
CMD echo "🚀 Starting NocoDB..." && nocodb
