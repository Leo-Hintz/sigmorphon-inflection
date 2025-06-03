import os
import json
import subprocess
import argparse
from pathlib import Path

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Train NLP models from config.")
parser.add_argument("-c", "--config", required=True, help="Path to the config JSON file")
parser.add_argument("-p", "--project_path", required=True, help="Path to the project directory")
args = parser.parse_args()

# Read config
with open(args.project_path + "/" + args.config) as config_file:
    config = json.load(config_file)
    models = config["models"]
    languages = config["languages"]
    
# Run training scripts
for model in models:
    for language in languages:
        path = Path(args.project_path + "/" + model["train_path"])
        print(f"Training model {model['name']} on {language}")
        subprocess.run(["python3", path.name, "--language", language], cwd=path.parent, check=True)
