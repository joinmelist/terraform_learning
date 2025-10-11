#!/bin/bash
set -e

echo "========== Updating system =========="
sudo apt update -y && sudo apt upgrade -y

echo "========== Installing Node.js + PM2 =========="
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2

echo "========== Installing Nginx =========="
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

echo "========== Installing Python 3.10 and dependencies =========="
sudo apt install -y python3.10 python3.10-venv python3.10-distutils python3-pip

echo "========== Setting up FastAPI project =========="
APP_DIR="/var/www/fastapi_app"
sudo mkdir -p $APP_DIR
sudo chown ubuntu:ubuntu -R $APP_DIR
cd $APP_DIR

# Create virtual environment
python3.10 -m venv venv
source venv/bin/activate

# Install FastAPI + Uvicorn
pip install --upgrade pip
pip install fastapi uvicorn

# Create a simple FastAPI app
cat <<EOF > $APP_DIR/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Hello from FastAPI + Nginx + PM2 + Node!"}
EOF

# Create a systemd service for FastAPI
echo "========== Creating FastAPI systemd service =========="
sudo tee /etc/systemd/system/fastapi.service > /dev/null <<EOL
[Unit]
Description=FastAPI application
After=network.target

[Service]
User=ubuntu
WorkingDirectory=$APP_DIR
ExecStart=$APP_DIR/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable fastapi
sudo systemctl start fastapi

echo "========== Configuring Nginx reverse proxy =========="
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

sudo nginx -t && sudo systemctl restart nginx

echo "========== Setup complete =========="
echo "Visit your server's public IP in the browser to see your FastAPI app running via Nginx!"
