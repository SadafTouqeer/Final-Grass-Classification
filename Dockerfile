# Use a specific Python image that often has better build tools for ML
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Use the command from your Procfile to start the application
CMD gunicorn app:app
