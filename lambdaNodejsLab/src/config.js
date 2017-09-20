// Copyright 2017 Amazon Web Services, Inc. or its affiliates. All rights reserved.

module.exports = {
  // STUDENT TODO 1: Set the region (example: 'us-west-2')
  region: 'us-east-1',
  // STUDENT TODO 2: Set the bucket names (created by running 'grunt createBuckets')
  inputBucket: 'csab-lambda-lab-input-1',
  outputBucket: 'csab-lambda-lab-output-1',
  // STUDENT TODO 3: Set the ARN of the Lambda function (starts with arn:aws:lambda)
  lambdaARN: 'arn:aws:lambda:us-east-1:440691642093:function:LambdaTransformer'
}
