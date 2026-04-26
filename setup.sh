#!/usr/bin/env bash

set -euo pipefail

PROJECT_NAME="adcs_kalman_test_workstation"
VENV_DIR=".venv"

echo "Setting up ${PROJECT_NAME}..."

# ---------------------------------------------------------------------
# Check Python
# ---------------------------------------------------------------------

if ! command -v python3 >/dev/null 2>&1; then
    echo "ERROR: python3 is not installed or not on PATH."
    exit 1
fi

PYTHON_VERSION="$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
echo "Detected Python ${PYTHON_VERSION}"

# ---------------------------------------------------------------------
# Create virtual environment
# ---------------------------------------------------------------------

if [ ! -d "${VENV_DIR}" ]; then
    echo "Creating virtual environment at ${VENV_DIR}..."
    python3 -m venv "${VENV_DIR}"
else
    echo "Virtual environment already exists at ${VENV_DIR}."
fi

# ---------------------------------------------------------------------
# Activate virtual environment
# ---------------------------------------------------------------------

# shellcheck disable=SC1091
source "${VENV_DIR}/bin/activate"

python -m pip install --upgrade pip setuptools wheel

# ---------------------------------------------------------------------
# Install package and dependencies
# ---------------------------------------------------------------------

if [ -f "pyproject.toml" ]; then
    echo "Installing project in editable mode with dev dependencies..."
    python -m pip install -e ".[dev]"
else
    echo "pyproject.toml not found. Falling back to requirements.txt..."
    python -m pip install -r requirements.txt
fi

# ---------------------------------------------------------------------
# Create required directories
# ---------------------------------------------------------------------

echo "Creating project directories..."

mkdir -p configs
mkdir -p docs

mkdir -p src/adcs_isvs
mkdir -p src/adcs_isvs/workstation
mkdir -p src/adcs_isvs/dynamics
mkdir -p src/adcs_isvs/sensors
mkdir -p src/adcs_isvs/estimators
mkdir -p src/adcs_isvs/controllers
mkdir -p src/adcs_isvs/scenarios
mkdir -p src/adcs_isvs/analysis
mkdir -p src/adcs_isvs/reporting
mkdir -p src/adcs_isvs/utils

mkdir -p tests
mkdir -p scripts

mkdir -p data/raw
mkdir -p data/processed
mkdir -p data/archived_runs

mkdir -p results/plots
mkdir -p results/tables
mkdir -p results/reports
mkdir -p results/screenshots

mkdir -p notebooks

# ---------------------------------------------------------------------
# Add .gitkeep files for empty directories
# ---------------------------------------------------------------------

touch data/raw/.gitkeep
touch data/processed/.gitkeep
touch data/archived_runs/.gitkeep

touch results/plots/.gitkeep
touch results/tables/.gitkeep
touch results/reports/.gitkeep
touch results/screenshots/.gitkeep

# ---------------------------------------------------------------------
# Add package init files if missing
# ---------------------------------------------------------------------

touch src/adcs_isvs/__init__.py
touch src/adcs_isvs/workstation/__init__.py
touch src/adcs_isvs/dynamics/__init__.py
touch src/adcs_isvs/sensors/__init__.py
touch src/adcs_isvs/estimators/__init__.py
touch src/adcs_isvs/controllers/__init__.py
touch src/adcs_isvs/scenarios/__init__.py
touch src/adcs_isvs/analysis/__init__.py
touch src/adcs_isvs/reporting/__init__.py
touch src/adcs_isvs/utils/__init__.py

# ---------------------------------------------------------------------
# Make scripts executable if present
# ---------------------------------------------------------------------

if [ -d "scripts" ]; then
    chmod +x scripts/*.sh 2>/dev/null || true
fi

# ---------------------------------------------------------------------
# Smoke test
# ---------------------------------------------------------------------

echo "Running setup smoke test..."
python -c "import numpy, scipy, pandas, matplotlib, yaml, filterpy; print('Python stack OK')"

echo ""
echo "Setup complete."
echo ""
echo "Next steps:"
echo "  source ${VENV_DIR}/bin/activate"
echo "  pytest"
echo "  adcs-isvs --help"
