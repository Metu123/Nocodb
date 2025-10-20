# ---------------------------
# ✅ NocoDB Auto Backend (Node 22 + Render Ready)
# ---------------------------

# Use the latest stable Node 22 Alpine image
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install NocoDB globally
RUN npm install -g nocodb@latest --ignore-scripts

# Expose the NocoDB default port
EXPOSE 8080

# Define environment variables (Render overrides these automatically)
ENV PORT=8080
ENV DATABASE_URL=${DATABASE_URL}
ENV NC_ADMIN_EMAIL=${NC_ADMIN_EMAIL}
ENV NC_ADMIN_PASSWORD=${NC_ADMIN_PASSWORD}
ENV NC_AUTH_JWT_SECRET=${NC_AUTH_JWT_SECRET}
ENV NC_PUBLIC_URL=${NC_PUBLIC_URL}

# Health check (optional)
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget --quiet --spider http://localhost:8080 || exit 1

# Start NocoDB
CMD ["npx", "nocodb"]
