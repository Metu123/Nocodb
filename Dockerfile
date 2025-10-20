# Use Node.js LTS as base
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install system dependencies (bash, curl, PostgreSQL client)
RUN apk add --no-cache bash curl postgresql-client

# Install NocoDB globally via npm
RUN npm install -g nocodb

# Expose NocoDB port
EXPOSE 8080

# Set environment variables
ENV DATABASE_URL=pg://blogdb_wa32_user:CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ@dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com:5432/blogdb_wa32?ssl=true
ENV NC_ADMIN_EMAIL=desta1037@gmail.com
ENV NC_ADMIN_PASSWORD=admin123
ENV NC_AUTH_JWT_SECRET=supersecretjwtkey
ENV NC_PUBLIC_URL=https://<your-render-app>.onrender.com
ENV PORT=8080

# Add startup script directly
RUN echo '#!/bin/bash\n\
set -e\n\
echo "🚀 Starting NocoDB setup..."\n\
echo "🔍 Checking PostgreSQL connection..."\n\
until pg_isready -d "$DATABASE_URL" > /dev/null 2>&1; do\n\
  echo "⏳ Waiting for database..."\n\
  sleep 3\n\
done\n\
echo "✅ Database is reachable!"\n\
echo "🚀 Starting NocoDB..."\n\
npx nc start --port 8080' > /app/start.sh \
&& chmod +x /app/start.sh

# Start container using the embedded startup script
CMD ["/app/start.sh"]
