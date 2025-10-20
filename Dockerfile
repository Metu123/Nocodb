FROM nocodb/nocodb:latest

# Copy .env file
COPY .env .env

EXPOSE 8080

CMD npx nocodb serve --port ${PORT:-8080}
