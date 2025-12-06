# Environment as Code for ML

A fully codified, reproducible Machine Learning environment using Docker Compose and Dev Containers.

## Features
- **Microservices Architecture**: Orchestrates JupyterLab, MLflow, PostgreSQL, and MinIO.
- **Reproducibility**: Docker-based environment ensuring identical runs across machines.
- **Experiment Tracking**: Integrated MLflow with Postgres backend and MinIO artifact storage.
- **Data Versioning**: DVC configured with S3-compatible storage (MinIO).
- **Hybrid Compute**: Support for both CPU-optimized and GPU-accelerated (NVIDIA) workflows.

## Prerequisites
- Docker Desktop
- VS Code with "Dev Containers" extension

## Quick Start
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/harshithluc073/ml-code-editor.git
    cd ml-code-editor
    ```

2.  **Start the environment**:
    ```bash
    make up
    ```

3.  **Initialize DVC** (First time only):
    ```bash
    make dvc-init
    ```

4.  **Access Services**:
    - **JupyterLab**: [http://localhost:8888](http://localhost:8888) (Passwordless)
    - **MLflow UI**: [http://localhost:5000](http://localhost:5000)
    - **MinIO Console**: [http://localhost:9001](http://localhost:9001) (User: `minioadmin`, Pass: `minioadmin`)

## Architecture
- **Jupyter**: Main compute node for development.
- **MLflow**: Tracking server for experiments and model registry.
- **Postgres**: Backend database for MLflow metadata.
- **MinIO**: Object storage mocking AWS S3 for artifacts and DVC remote.

