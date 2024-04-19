FROM python:3.11-slim

# Install dependencies.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code to the container.
WORKDIR /app
COPY . .

# Run the app.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]