FROM nocodb/nocodb:latest

# Expose dynamic port for Render
ENV PORT=${PORT:-8080}
EXPOSE $PORT

# Start NocoDB directly (no npx needed)
CMD ["nc", "serve", "--port", "8080"]
