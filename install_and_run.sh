#!/bin/bash

set -e

PROJECT_DIR=$(pwd)
SERVICE_NAME="sampleapp"
PY_VERSION="3.12"

echo "==> Updating system..."
sudo apt update

echo "==> Installing Python ${PY_VERSION} and required tools..."
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python${PY_VERSION} python${PY_VERSION}-venv python3-pip

echo "==> Installing pipenv..."
pip3 install --user pipenv

# Ensure ~/.local/bin is in PATH
export PATH="$HOME/.local/bin:$PATH"

echo "==> Creating virtual environment using Pipfile..."
pipenv --python ${PY_VERSION}

echo "==> Installing project dependencies..."
pipenv install

echo "==> Creating systemd service..."

SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

sudo bash -c "cat > ${SERVICE_FILE}" <<EOF
[Unit]
Description=SampleApp FastAPI Service
After=network.target

[Service]
User=${USER}
WorkingDirectory=${PROJECT_DIR}
Environment=PATH=${HOME}/.local/bin:/usr/local/bin:/usr/bin:/bin
ExecStart=$(pipenv --venv)/bin/python ${PROJECT_DIR}/main.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "==> Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "==> Enabling service to start on boot..."
sudo systemctl enable ${SERVICE_NAME}

echo "==> Starting service now..."
sudo systemctl start ${SERVICE_NAME}

echo "==> Done! Service status:"
sudo systemctl status ${SERVICE_NAME} --no-pager
