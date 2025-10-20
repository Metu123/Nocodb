# Use official NocoDB image
FROM nocodb/nocodb:latest

# Install pnpm globally (optional, if you want to use pnpm)
RUN npm install -g pnpm

# Set environment variables (can be overridden in Render dashboard)
ENV NC_DB="postgres://blogdb_wa32_user:CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ@dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com:5432/blogdb_wa32?ssl=true"
ENV NC_AUTH_JWT_SECRET="569a1821-0a93-45e8-87ab-eb857f20a010"
ENV NC_PUBLIC_URL="https://nocodb-h7te.onrender.com"

# Expose Render dynamic port
ENV PORT=${PORT:-8080}
EXPOSE $PORT

# Use production start (no local dev config required)
CMD ["pnpm", "start"]
