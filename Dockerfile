# Dockerfile for Directus on Render

# Use the official Directus image
FROM directus/directus:latest

# Optional: copy extensions if you have any
# COPY ./extensions /directus/extensions

# Optional: copy uploads if you want, but cloud storage is recommended
# COPY ./uploads /directus/uploads

# Do NOT set CMD — the official image already starts Directus correctly
# The container will use the built-in entrypoint
