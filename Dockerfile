# Use the official NocoDB image as base
FROM nocodb/nocodb:latest

# Set environment variables (can be overridden via Render dashboard)
ENV NC_DB="postgres://blogdb_wa32_user:CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ@dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com:5432/blogdb_wa32?ssl=true"
ENV NC_AUTH_JWT_SECRET="569a1821-0a93-45e8-87ab-eb857f20a010"
ENV NC_PUBLIC_URL="https://nocodb-h7te.onrender.com"

# Expose Render dynamic port
ENV PORT=${PORT:-8080}
EXPOSE $PORT

# Optional: install pnpm globally (if you want to use pnpm commands inside container)
RUN npm install -g pnpm

# Start NocoDB in production mode
CMD ["pnpm", "start"]
