# go_lambda_test
Building your function
Preparing a binary to deploy to AWS Lambda requires that it is compiled for Linux and placed into a .zip file. When using the provided, provided.al2, or provided.al2023 runtime, the executable within the .zip file should be named bootstrap. Lambda's default architecture is x86_64, so when cross compiling from a non-x86 environment, the executable should be built with GOARCH=amd64. Likewise, if the Lambda function will be configured to use ARM, the executable should built with GOARCH=arm64.

To get all the dependencies:
```
go get -u
```

Run the executable file:
```sh
chmod +x deploy_lambda.sh
```
Run the Script: Execute the script by running the following command in the terminal:

```sh
./deploy_lambda.sh
```

Build steps:
```
GOOS=linux GOARCH=amd64 go build -o bootstrap main.go
#Before zipping
chmod +x bootstrap
zip deployment.zip bootstrap
```




To upload to aws 
```
aws lambda update-function-code --function-name <function-name> --region us-west-2 --zip-file fileb://deployment.zip
```
