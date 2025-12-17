# Use Node.js 18 LTS Alpine for smaller image size
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the application
COPY . .

# Make the CLI executable
RUN chmod +x diagram-cli.js

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S diagramuser -u 1001

# Change ownership of the app directory
RUN chown -R diagramuser:nodejs /app

# Switch to non-root user
USER diagramuser

# Set the entrypoint to the CLI tool
ENTRYPOINT ["node", "diagram-cli.js"]

# Default command (can be overridden)
CMD ["--help"]
