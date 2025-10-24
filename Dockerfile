# Step 1: Use a specific, small base Python image
# 3.10 is a good, stable version.
FROM python:3.10-slim

# Step 2: Set the working directory for the application inside the container
WORKDIR /app

# Step 3: Copy only the necessary files for dependency installation first
# We do not need the full requirements.txt file anymore since we specify packages below.
# However, we'll keep the COPY command as a placeholder/best practice.
COPY requirements.txt .

# Step 4: Install Dependencies in two phases to target CPU-only PyTorch
# Phase A: Install standard, smaller dependencies
RUN pip install --no-cache-dir Flask==3.0.3 Pillow gunicorn

# Phase B: Install CPU-only versions of PyTorch and Torchvision
# This drastically reduces the image size below the 4GB limit.
RUN pip install torch==2.4.0+cpu torchvision==0.19.0+cpu --extra-index-url https://download.pytorch.org/whl/cpu

# Step 5: Copy the rest of the application files (code, templates, model, etc.)
COPY . .

# Step 6: Define the command that starts the web application
# This is equivalent to your Procfile: web: gunicorn app:app
CMD ["gunicorn", "app:app"]
