version: "3.9"

services:
  directus:
    image: directus/directus:latest
    ports:
      - "8055:8055"
    # Volumes are optional on Render; for uploads use S3/Object Storage
    # - ./uploads:/directus/uploads
    # - ./extensions:/directus/extensions
    environment:
      SECRET: "YOUR_SECRET_HERE"

      DB_CLIENT: "pg"
      DB_HOST: "dpg-d3r1qemmcj7s73bipki0-a.oregon-postgres.render.com"
      DB_PORT: "5432"
      DB_DATABASE: "blogdb_wa32"
      DB_USER: "blogdb_wa32_user"
      DB_PASSWORD: "CIGGSSBf8qGb7Y1Ej5kKoVlelMnRm8rZ"
      DB_SSL: "true"

      ADMIN_EMAIL: "desta1037@gmail.com"
      ADMIN_PASSWORD: "strongpassword"

      PUBLIC_URL: "https://your-directus-app.onrender.com"

    # Healthcheck is optional on Render
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8055/_/health || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
