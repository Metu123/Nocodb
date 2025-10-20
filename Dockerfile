# Use Node.js LTS
FROM node:20-alpine

WORKDIR /app

# Install system dependencies
RUN apk add --no-cache bash curl postgresql-client git

# Install pnpm
RUN npm install -g pnpm

# Install NocoDB using pnpm
RUN pnpm add -g nocodb

# Expose port
EXPOSE 8080

# Environment variables
ENV DATABASE_URL=pg://blogdb_wa32_user:CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ@dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com:5432/blogdb_wa32?ssl=true
ENV NC_ADMIN_EMAIL=desta1037@gmail.com
ENV NC_ADMIN_PASSWORD=admin123
ENV NC_AUTH_JWT_SECRET=supersecretjwtkey
ENV NC_PUBLIC_URL=https://<your-render-app>.onrender.com
ENV PORT=8080

# Embedded startup script
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

CMD ["/app/start.sh"]
