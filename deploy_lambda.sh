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
FUNCTION_NAME="GO_CustomMetric_Saket_test"
AWS_REGION="us-west-2"

#Test

# aws lambda create-function --function-name $FUNCTION_NAME \
# --zip-file fileb://deployment.zip \
# --handler example.LambdaFunction::handleRequest \
# --runtime provided.al2023 \
# --region $AWS_REGION \
# --architectures x86_64 \
# --role arn:aws:iam::<aws-account-number>:role/nr_extension_test_lambda_execution_role


aws lambda update-function-code --function-name $FUNCTION_NAME --region $AWS_REGION --zip-file fileb://deployment.zip > aws_output.log 2>&1

echo "Deployment to AWS Lambda function $FUNCTION_NAME completed successfully."
