.PHONY: setup venv install clean

# Python version to use
PYTHON := python3
VENV_NAME := .venv
VENV_PYTHON := $(VENV_NAME)/bin/python

# Default target
all: setup

# Create virtual environment and install dependencies
setup: venv install

# Create virtual environment using uv
.venv:
	uv venv $(VENV_NAME)

# Install dependencies using uv
install:
	uv pip sync requirements.txt

# Upgrade all dependencies
upgrade:
	uv pip compile requirements.txt --upgrade
	uv pip sync requirements.txt

# Clean up virtual environment
clean:
	rm -rf $(VENV_NAME)
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

# Display help message
help:
	@echo "Available targets:"
	@echo "  setup    - Create virtual environment and install dependencies"
	@echo "  venv     - Create virtual environment only"
	@echo "  install  - Install dependencies using uv"
	@echo "  upgrade  - Upgrade all dependencies"
	@echo "  clean    - Remove virtual environment and cache files"
	@echo "  help     - Display this help message"
