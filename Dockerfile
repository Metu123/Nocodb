# Dockerfile for Render

# Use the official Directus image
FROM directus/directus:latest

# Optional: copy local extensions
# COPY ./extensions /directus/extensions

# Optional: copy uploads if you want, but cloud storage is recommended
# COPY ./uploads /directus/uploads

# Set the start command
CMD ["directus", "start"]
