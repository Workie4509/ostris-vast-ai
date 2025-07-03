#!/bin/bash
set -e  # Stop on error
echo " Starting provisioning for ostris/ai-toolkit..."

# Install system dependencies if needed
apt-get update && apt-get install -y git curl python3-venv

# Set working directory
mkdir -p /workspace && cd /workspace

# Clone the AI Toolkit repo if not already present
if [ ! -d "ai-toolkit" ]; then
    git clone https://github.com/ostris/ai-toolkit.git
fi
cd ai-toolkit

# Initialize submodules
git submodule update --init --recursive

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install PyTorch (default: latest CPU version, or you can customize for CUDA)
pip install --no-cache-dir torch

# Install main requirements
pip install --no-cache-dir -r requirements.txt

# Optional: Fix dependency issues or upgrade common deep learning tools
pip install --upgrade accelerate transformers diffusers huggingface_hub || true

echo " AI Toolkit setup complete. Ready for use!"
