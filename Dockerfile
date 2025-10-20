FROM nocodb/nocodb:latest

# Optional: install pnpm globally (if you need it)
RUN npm install -g pnpm

# Expose the port Render provides
ENV PORT=${PORT:-8080}
EXPOSE $PORT

# Start NocoDB in production
CMD ["npx", "nocodb", "start"]
