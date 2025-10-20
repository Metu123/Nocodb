FROM nocodb/nocodb:latest

# Expose dynamic port
ENV PORT=${PORT:-8080}
EXPOSE $PORT

# Start NocoDB
CMD npx nocodb serve --port $PORT
