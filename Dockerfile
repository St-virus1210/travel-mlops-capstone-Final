FROM python:3.11-slim
WORKDIR /app
COPY requirements-api.txt .
RUN pip install --no-cache-dir -r requirements-api.txt
COPY . .
EXPOSE 5000
CMD ["python", "api/app.py"]
