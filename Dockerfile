# Use official Python base image with GPU support
FROM nvcr.io/nvidia/cuda:12.2.0-base-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    WORKDIR=/workspace \
    JUPYTER_CONFIG_DIR=/root/.jupyter \
    VENV_PATH=/opt/venv

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    git \
    curl \
    nano \
    htop \
    procps \
    bash-completion \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Configure Python - only create links if they don't exist
RUN if [ ! -e /usr/bin/python ]; then ln -s /usr/bin/python3 /usr/bin/python; fi
RUN if [ ! -e /usr/bin/pip ]; then ln -s /usr/bin/pip3 /usr/bin/pip; fi

# Configure bash environment
RUN echo 'export PS1="\\u@\\h:\\w\\$ "' >> /etc/bash.bashrc && \
    echo 'alias ll="ls -alF"' >> /etc/bash.bashrc && \
    echo 'alias la="ls -A"' >> /etc/bash.bashrc && \
    echo 'source /etc/bash_completion' >> /etc/bash.bashrc

# Copy requirements
COPY requirements.txt /tmp/requirements.txt

# Create and activate virtual environment
RUN python -m venv ${VENV_PATH}
ENV PATH="${VENV_PATH}/bin:$PATH"

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt

# Create workspace
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

# Create Jupyter config directory
RUN mkdir -p ${JUPYTER_CONFIG_DIR}

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose Jupyter port
EXPOSE 8888

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s \
    CMD curl -f http://localhost:8888/api || exit 1

# Set entrypoint
ENTRYPOINT ["entrypoint.sh"]
