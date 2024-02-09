#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Compile the Go application
GOOS=linux GOARCH=amd64 go build -o bootstrap main.go

# Set execute permissions for the bootstrap file
chmod +x bootstrap

# Zip the bootstrap file
zip deployment.zip bootstrap

# Upload the deployment package to AWS Lambda
# Replace <function-name> with your actual Lambda function name
FUNCTION_NAME="your-function-name"
AWS_REGION="us-west-2"

aws lambda update-function-code --function-name $FUNCTION_NAME --region $AWS_REGION --zip-file fileb://deployment.zip

echo "Deployment to AWS Lambda function $FUNCTION_NAME completed successfully."
