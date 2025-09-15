# Use an official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (for pip + npm)
RUN apt-get update && apt-get install -y \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install pip-compile-multi
RUN pip install --no-cache-dir pip-compile-multi

# Copy dependency files first for caching
COPY requirements* ./

# Compile requirements
RUN pip-compile-multi

# Install Node.js dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the code
COPY . .

# Expose app port
EXPOSE 7890

# Default command (adjust for your app entrypoint)
CMD ["python", "app.py"]
