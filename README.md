# GPU-Enabled JupyterLab Container

Docker setup for JupyterLab with NVIDIA GPU support

## Features
- CUDA 12.2 base image
- Persistent workspace volume
- Password authentication
- GPU resource allocation

## Requirements
- Docker Engine 20.10+
- NVIDIA Container Toolkit
- Docker Compose 2.0+

## Setup
1. Create \`.env\` file:
   \`\`\`bash
   echo "JUPYTER_PASSWORD=your_secure_password" > .env
   \`\`\`
2. Start container:
   \`\`\`bash
   docker compose up -d
   \`\`\`
3. Access JupyterLab: http://localhost:8888

## Configuration
- Edit \`docker-compose.yml\` for port changes
- Edit \`requirements.txt\` for Python packages
