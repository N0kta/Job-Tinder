# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /Job-Tinder

# Install system dependencies if needed (e.g. psycopg2)
RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (for caching layers)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app (ignores venv/ etc. thanks to .dockerignore)
COPY . .

# Expose FastAPI port
EXPOSE 8000

#Switch pwd to run Uvicorn
WORKDIR /Job-Tinder/backend

# Start FastAPI with uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
