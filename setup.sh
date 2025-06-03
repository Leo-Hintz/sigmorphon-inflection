#!/bin/bash

apt-get update && apt-get install -y jq build-essential python3-dev

# Get the directory where the script is located
config_path="config.json"
while getopts "c:p:" opt; do
    case $opt in
        c) config_path=$OPTARG;;
        p) project_path=$OPTARG;;
        *) echo "USAGE: $0 -c <config_path> -p <project_path>"
            exit 1;;
    esac
done

conda_path=$(jq -r '.conda_path' "$project_path/$config_path")
python_version=$(jq -r '.python_version' "$project_path/$config_path")
requirements_path=$(jq -r '.requirements_path' "$project_path/$config_path")
mount_path=$(jq -r '.mount_path' "$project_path/$config_path")

# install conda environment
wget -nc https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $conda_path -u


# Initialize conda for bash shell
export PATH="$conda_path/bin:$PATH"
eval "$($conda_path/bin/conda shell.bash hook)"

# Create the conda environment with proper Python version specification
conda create -n inflection python=$python_version -y

# Activate the environment
conda activate inflection
echo path is: $project_path
# Install requirements with pip
pip install --no-cache-dir -r "$project_path/$requirements_path"
