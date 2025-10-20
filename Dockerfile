# Use official Node.js Alpine image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache bash curl postgresql-client git

# Install pnpm
RUN npm install -g pnpm

# Setup pnpm global directory
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN pnpm setup

# Install NocoDB globally
RUN pnpm add -g nocodb

# Expose NocoDB default port
EXPOSE 8080

# Environment variables (example, replace with your actual values)
ENV DATABASE_URL=postgres://user:password@host:5432/dbname?ssl=true
ENV NC_ADMIN_EMAIL=admin@example.com
ENV NC_ADMIN_PASSWORD=admin123
ENV NC_AUTH_JWT_SECRET=supersecretjwtkey
ENV NC_PUBLIC_URL=https://<your-render-app>.onrender.com
ENV PORT=8080

# Start script
RUN echo '#!/bin/bash\n\
set -e\n\
echo "🚀 Starting NocoDB..."\n\
npx nc start --port 8080' > /app/start.sh \
&& chmod +x /app/start.sh

# Default command
CMD ["/app/start.sh"]
