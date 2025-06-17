# GPU-Enabled JupyterLab Container

Docker setup for JupyterLab with full NVIDIA GPU acceleration support. Ideal for machine learning, deep learning, and scientific computing workflows. Pre-configured with CUDA libraries and Python data science stack.

![JupyterLab with GPU](https://example.com/gpu-jupyter-demo.jpg) *Add screenshot link here*

## ✨ Features

* **CUDA 12.2** base image for full GPU acceleration
* **Persistent storage** for notebooks and datasets
* **Secure authentication** with password protection
* **Resource isolation** for GPU devices
* **Pre-installed** common Python ML packages
* **Customizable** environment via Dockerfile
* **Docker Compose** for single-command management

## ⚙️ System Requirements

* **Docker Engine** 20.10+
* **NVIDIA Container Toolkit** ([Install Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html))
* **NVIDIA Drivers** 525.60+ ([Driver Download](https://www.nvidia.com/drivers))
* **Docker Compose** 2.0+
* Minimum 10GB free disk space

## 🚀 Setup Guide

### 1. Configure Environment

Create password file (replace `your_secure_password`):

```bash
echo "JUPYTER_PASSWORD=your_secure_password" > .env
```

### 2. Build Docker Image (Mandatory Step)

```bash
docker compose build --no-cache
```

*Note: `--no-cache` ensures fresh dependencies install. Remove for faster rebuilds when not changing packages.*

### 3. Launch Container

```bash
docker compose up -d
```

### 4. Access JupyterLab

Open in browser:

```
http://localhost:8888
```

🔑 Password: `your_secure_password` (from `.env` file)

## ⚙️ Configuration

| File                 | Purpose              | Customization                              |
| -------------------- | -------------------- | ------------------------------------------ |
| `docker-compose.yml` | Container definition | Port mapping, volume locations, GPU limits |
| `requirements.txt`   | Python packages      | Add/remove Python dependencies             |
| `Dockerfile`         | Image build recipe   | System packages, environment variables     |
| `.env`               | Secrets              | Jupyter password                           |

### Common Customizations:

**Change Jupyter port** (edit `docker-compose.yml`):

```yaml
ports:
  - "8999:8888"  # Host:Container port
```

**Add Python packages** (edit `requirements.txt`):

```text
torch==2.1.0
transformers==4.35
xgboost==2.0.0
```

**Limit GPU access** (edit `docker-compose.yml`):

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: 1  # Use only 1 GPU
          capabilities: [gpu]
```

## 🛠️ Management Commands

| Command                            | Action                |
| ---------------------------------- | --------------------- |
| `docker compose logs -f`           | View real-time logs   |
| `docker compose exec jupyter bash` | Enter container shell |
| `docker compose restart`           | Restart service       |
| `docker compose down`              | Stop container        |
| `docker compose pull`              | Update base images    |

## ⚠️ Troubleshooting

**GPU not detected?** Verify:

* `nvidia-smi` shows available GPUs on host
* NVIDIA Container Toolkit is properly installed
* Docker has GPU access:

```bash
docker run --rm --gpus all nvidia/cuda:12.2.0-base nvidia-smi
```

**Port conflict?** Change host port mapping in `docker-compose.yml`:

```yaml
ports:
  - "NEW_PORT:8888"  # e.g., 9999:8888
```

## 📂 Directory Structure

```text
.
├── Dockerfile             # Image build instructions
├── docker-compose.yml     # Container configuration
├── requirements.txt       # Python dependencies
├── workspace/             # Persistent notebooks (auto-created)
└── .env                   # Environment variables
```
# GPU-Enabled JupyterLab Container

Docker setup for JupyterLab with full NVIDIA GPU acceleration support. Ideal for machine learning, deep learning, and scientific computing workflows. Pre-configured with CUDA libraries and Python data science stack.

![JupyterLab with GPU](https://example.com/gpu-jupyter-demo.jpg) *Add screenshot link here*

## ✨ Features

* **CUDA 12.2** base image for full GPU acceleration
* **Persistent storage** for notebooks and datasets
* **Secure authentication** with password protection
* **Resource isolation** for GPU devices
* **Pre-installed** common Python ML packages
* **Customizable** environment via Dockerfile
* **Docker Compose** for single-command management

## ⚙️ System Requirements

* **Docker Engine** 20.10+
* **NVIDIA Container Toolkit** ([Install Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html))
* **NVIDIA Drivers** 525.60+ ([Driver Download](https://www.nvidia.com/drivers))
* **Docker Compose** 2.0+
* Minimum 10GB free disk space

## 🚀 Setup Guide

### 1. Configure Environment

Create password file (replace `your_secure_password`):

```bash
echo "JUPYTER_PASSWORD=your_secure_password" > .env
```

### 2. Build Docker Image (Mandatory Step)

```bash
docker compose build --no-cache
```

*Note: `--no-cache` ensures fresh dependencies install. Remove for faster rebuilds when not changing packages.*

### 3. Launch Container

```bash
docker compose up -d
```

### 4. Access JupyterLab

Open in browser:

```
http://localhost:8888
```

🔑 Password: `your_secure_password` (from `.env` file)

## ⚙️ Configuration

| File                 | Purpose              | Customization                              |
| -------------------- | -------------------- | ------------------------------------------ |
| `docker-compose.yml` | Container definition | Port mapping, volume locations, GPU limits |
| `requirements.txt`   | Python packages      | Add/remove Python dependencies             |
| `Dockerfile`         | Image build recipe   | System packages, environment variables     |
| `.env`               | Secrets              | Jupyter password                           |

### Common Customizations:

**Change Jupyter port** (edit `docker-compose.yml`):

```yaml
ports:
  - "8999:8888"  # Host:Container port
```

**Add Python packages** (edit `requirements.txt`):

```text
torch==2.1.0
transformers==4.35
xgboost==2.0.0
```

**Limit GPU access** (edit `docker-compose.yml`):

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: 1  # Use only 1 GPU
          capabilities: [gpu]
```

## 🛠️ Management Commands

| Command                            | Action                |
| ---------------------------------- | --------------------- |
| `docker compose logs -f`           | View real-time logs   |
| `docker compose exec jupyter bash` | Enter container shell |
| `docker compose restart`           | Restart service       |
| `docker compose down`              | Stop container        |
| `docker compose pull`              | Update base images    |

## ⚠️ Troubleshooting

**GPU not detected?** Verify:

* `nvidia-smi` shows available GPUs on host
* NVIDIA Container Toolkit is properly installed
* Docker has GPU access:

```bash
docker run --rm --gpus all nvidia/cuda:12.2.0-base nvidia-smi
```

**Port conflict?** Change host port mapping in `docker-compose.yml`:

```yaml
ports:
  - "NEW_PORT:8888"  # e.g., 9999:8888
```

## 📂 Directory Structure

```text
.
├── Dockerfile             # Image build instructions
├── docker-compose.yml     # Container configuration
├── requirements.txt       # Python dependencies
├── workspace/             # Persistent notebooks (auto-created)
└── .env                   # Environment variables
```

