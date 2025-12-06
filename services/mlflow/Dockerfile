FROM python:3.9-slim

RUN pip install --no-cache-dir mlflow psycopg2-binary boto3

EXPOSE 5000

# Use shell form to ensure environment variables are expanded
CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --backend-store-uri $BACKEND_STORE_URI \
    --default-artifact-root $ARTIFACT_ROOT
