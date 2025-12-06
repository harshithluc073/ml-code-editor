.PHONY: up down build shell dvc-init

up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build

shell:
	docker compose exec jupyter bash

dvc-init:
	docker compose exec jupyter dvc init --no-scm
	docker compose exec jupyter dvc remote add -d minio s3://dvc-store
	docker compose exec jupyter dvc remote modify minio endpointurl http://minio:9000
	docker compose exec jupyter dvc remote modify minio access_key_id minioadmin
	docker compose exec jupyter dvc remote modify minio secret_access_key minioadmin
	@echo "DVC initialized and configured to use MinIO."
