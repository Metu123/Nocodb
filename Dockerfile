# ---------------------------
# ✅ Render-ready Dockerfile for NocoDB using Node 22-alpine
# ---------------------------

FROM node:22-alpine

WORKDIR /app

# Install required packages and pnpm first
RUN apk add --no-cache wget bash \
  && npm install -g pnpm@latest \
  && pnpm add -g nocodb@latest

# Expose default port
EXPOSE 8080

ENV PORT=8080

# Health check for Render
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget --quiet --spider http://localhost:8080 || exit 1

# ✅ Start NocoDB via pnpm
CMD ["pnpm", "nocodb"]
