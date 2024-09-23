#!/bin/bash

# Variables
URL="https://www.amazon.in/"  # Replace with the application URL

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install curl and try again."
    exit 1
fi

# Check the application's HTTP status code
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

# Check if the STATUS_CODE variable is empty
if [ -z "$STATUS_CODE" ]; then
    echo "Failed to retrieve HTTP status code. The URL may be incorrect or unreachable."
    exit 1
fi

# Check if the application is up or down based on HTTP status code
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "The application is UP (HTTP $STATUS_CODE)."
else
    echo "The application is DOWN (HTTP $STATUS_CODE)."
fi


