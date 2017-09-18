# !/bin/bash
# Shows how to invoke a lambda with a string input for --payload
# The quote order is significant.
#
aws lambda invoke --function-name LambdaDemoInvokeStringArg --payload '"invoke-cli"'  invokeString-result.txt