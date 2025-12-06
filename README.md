# Environment as Code for ML

A fully codified, reproducible Machine Learning environment using Docker Compose and Dev Containers. This project treats infrastructure as code to eliminate "it works on my machine" issues by orchestrating a production-grade ML stack locally.

## Features
- **Microservices Architecture**: Orchestrates JupyterLab, MLflow, PostgreSQL, and MinIO.
- **Reproducibility**: Docker-based environment ensuring identical runs across machines.
- **Experiment Tracking**: Integrated MLflow with Postgres backend and MinIO artifact storage.
- **Data Versioning**: DVC configured with S3-compatible storage (MinIO).
- **Hybrid Compute**: Support for both CPU-optimized and GPU-accelerated (NVIDIA) workflows.
- **Code Quality**: Pre-configured `pre-commit` hooks for Linting (Flake8) and Formatting (Black).

## Prerequisites
- **Docker Desktop** (Ensure it's running)
- **VS Code** with "Dev Containers" extension installed.
- **Make** (Optional, but recommended for using the Makefile).

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
    *This command builds the Docker images and starts the containers. The first run may take a few minutes.*

3.  **Initialize DVC** (First time only):
    ```bash
    make dvc-init
    ```
    *This configures DVC inside the container to use the local MinIO service as the remote storage.*

4.  **Access Services**:
    | Service | URL | Credentials | Description |
    | :--- | :--- | :--- | :--- |
    | **JupyterLab** | [http://localhost:8888](http://localhost:8888) | (None) | Main development environment |
    | **MLflow UI** | [http://localhost:5000](http://localhost:5000) | (None) | Experiment tracking dashboard |
    | **MinIO Console** | [http://localhost:9001](http://localhost:9001) | `minioadmin` / `minioadmin` | Object storage browser |

## Project Structure
```
├── .devcontainer/       # VS Code Dev Container configuration
├── notebooks/           # Jupyter notebooks (Mounted to /home/jovyan/work)
├── services/            # Microservice configurations
│   ├── jupyter/         # JupyterLab Dockerfile & requirements
│   └── mlflow/          # MLflow Dockerfile
├── docker-compose.yml   # Main infrastructure definition
├── docker-compose.gpu.yml # GPU override configuration
├── Makefile             # Automation shortcuts
└── README.md            # You are here
```

## Workflow Guide
### 1. Developing Models
Open the `notebooks/` directory in JupyterLab. You can import standard libraries (pandas, sklearn, etc.).
To track experiments:
```python
import mlflow
mlflow.set_tracking_uri("http://mlflow:5000")
mlflow.autolog()
```

### 2. Versioning Data
Place your raw data in `data/` (create this folder if needed).
```bash
dvc add data/my_dataset.csv
git add data/my_dataset.csv.dvc .gitignore
git commit -m "Add dataset"
dvc push
```

### 3. GPU Support
If you have an NVIDIA GPU and proper drivers, the system attempts to use `docker-compose.gpu.yml`. 
Ensure your Docker Desktop is configured to support WSL 2 backend with GPU.

## Troubleshooting
- **Port Conflicts**: Ensure ports 8888, 5000, 9000, 9001, and 5432 are free.
- **DVC Error**: "Endpoint url cannot be set..." -> Ensure you ran `make dvc-init` *after* the containers are running.
- **Permission Issues**: If you cannot save notebooks, ensure the `notebooks` folder on your host is writable.

