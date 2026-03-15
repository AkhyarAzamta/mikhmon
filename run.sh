#!/usr/bin/env bash

# Create sessions directory if it doesn't exist
mkdir -p sessions

# Start PHP built-in server
echo "Starting Mikhmon server at http://localhost:8080..."
php -S 0.0.0.0:8080
