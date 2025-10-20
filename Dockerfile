# ---------------------------
# ✅ NocoDB Dockerfile (Node 22-alpine + PostgreSQL + Render)
# ---------------------------

FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install wget for healthcheck and NocoDB globally
RUN apk add --no-cache wget && npm install -g nocodb@latest --ignore-scripts

# Expose the default port
EXPOSE 8080

# Set environment variables (Render overrides these automatically)
ENV PORT=8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget --quiet --spider http://localhost:8080 || exit 1

# Start NocoDB directly (not through npm)
CMD ["noco"]
