# Use official NocoDB image
FROM nocodb/nocodb:latest

# Install pnpm globally
RUN npm install -g pnpm

# Set environment variables (can be overridden by Render dashboard)
ENV NC_DB="postgres://blogdb_wa32_user:CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ@dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com:5432/blogdb_wa32?ssl=true"
ENV NC_AUTH_JWT_SECRET="569a1821-0a93-45e8-87ab-eb857f20a010"
ENV NC_PUBLIC_URL="https://nocodb-h7te.onrender.com"

# Expose Render dynamic port
ENV PORT=${PORT:-8080}
EXPOSE $PORT

# Copy app source code
WORKDIR /usr/src/app
COPY . .

# Install dependencies using pnpm (this will include cross-env)
RUN pnpm install --frozen-lockfile

# Start NocoDB with pnpm
CMD ["pnpm", "start"]
