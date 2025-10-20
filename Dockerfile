# ---------------------------
# ✅ NocoDB Dockerfile for Render (Node 22-alpine)
# ---------------------------

FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install dependencies
RUN apk add --no-cache wget && npm install -g nocodb@latest

# Expose port
EXPOSE 8080

# Set environment variable for Render
ENV PORT=8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget --quiet --spider http://localhost:8080 || exit 1

# ✅ Start NocoDB using npx to avoid "module not found"
CMD ["npx", "nocodb"]
