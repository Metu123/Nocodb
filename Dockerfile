FROM nocodb/nocodb:latest

# Install pnpm globally (only if you really need it)
RUN npm install -g pnpm

# Copy your repo if needed
COPY . /usr/src/app
WORKDIR /usr/src/app

# Install dependencies
RUN pnpm install --frozen-lockfile

# Expose port
EXPOSE 8080

# Start NocoDB in production
CMD ["npx", "nocodb", "start"]
