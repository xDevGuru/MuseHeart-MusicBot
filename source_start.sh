#!/bin/bash --utf8

export PYTHONIOENCODING=utf8

trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT

# Set the path for the virtual environment activation script based on the OS type
if [[ $OSTYPE == "msys" ]]; then
  VENV_PATH=venv/Scripts/activate
else
  VENV_PATH=venv/bin/activate
fi

# Create the virtual environment if it does not already exist
if [ ! -d "venv" ]; then
  if [ -x "$(command -v py)" ]; then
    py -3 -m venv venv
  else
    python3 -m venv venv
  fi

  # Check if the virtual environment was created successfully
  if [ ! -d "venv" ]; then
    echo "The venv directory was not created! Check if Python is installed correctly (and that it is configured in PATH/env)"
    sleep 45
    exit 1
  fi

  # Activate the virtual environment and install dependencies
  source $VENV_PATH
  pip install -r requirements.txt
else
  # Activate the virtual environment if it already exists
  source $VENV_PATH
fi

echo "Starting bot (Ensure it is online)..."

# Uncomment the following lines if you want to log the bot's output
# mkdir -p ./.logs
# touch "./.logs/run.log"

# Start the bot and optionally log output
python main.py # 2>&1 | tee ./.logs/run.log

# Sleep for 120 seconds to keep the script running and allow for monitoring
sleep 120s
