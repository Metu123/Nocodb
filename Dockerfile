# Use lightweight Node.js Alpine image
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install required packages and pnpm
RUN apk add --no-cache wget bash curl \
    && npm install -g pnpm@latest

# Copy package.json and package-lock (if you have them)
# Not strictly necessary for global install, but useful for local dev
COPY package*.json ./

# Install NocoDB globally using pnpm
RUN pnpm add -g nocodb@latest

# Copy the rest of your app (optional, if you have local config or scripts)
COPY . .

# Expose the port NocoDB will run on
EXPOSE 8080

# Optional: automatically load .env if it exists (for local development)
# Render will override these with its environment variables
RUN if [ -f .env ]; then export $(cat .env | xargs); fi

# Run NocoDB
CMD ["npx", "nocodb", "serve", "--port", "8080"]
