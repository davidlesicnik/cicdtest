FROM python:3.13-slim

WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Cloud Run will set this environment variable
ENV PORT 8080

# Run the web service on container startup
CMD exec gunicorn --bind :${PORT} --workers 1 --threads 8 --timeout 0 main:app