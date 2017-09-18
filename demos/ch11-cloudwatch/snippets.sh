# http://docs.aws.amazon.com/cli/latest/reference/cloudwatch/index.html
#
# delete-alarms
# describe-alarm-history
# describe-alarms
# describe-alarms-for-metric
# disable-alarm-actions
# enable-alarm-actions
# get-metric-statistics
# list-metrics
# put-metric-alarm
# put-metric-data
#

# cd scratch directory
cd C:/dclsoftware/clients/GK/awsdemos/AwsDeveloper/scripts/scratch

# Describe Alarms
aws cloudwatch describe-alarms
aws cloudwatch describe-alarms --alarm-names CPUGreaterThan5Percent
aws cloudwatch describe-alarms-for-metric --metric-name "CPUUtilization" --namespace "AWS/EC2" --dimensions Name=InstanceId,Value=i-0489900b38b695ba6


# Alarm History
aws cloudwatch describe-alarm-history --alarm-name "CPUGreaterThan5Percent" --history-item-type StateUpdate


# list Metrics
aws cloudwatch list-metrics > list-metrics.json
aws cloudwatch list-metrics --namespace "AWS/Kinesis"


# get-metric-statistics
aws cloudwatch get-metric-statistics --namespace "AWS/Kinesis" --metric-name "IncomingBytes" --dimensions Name="StreamName",Value="DevDemoStream" \
--start-time 2017-05-09T00:00:00 --end-time 2017-05-09T23:59:59 --period 60 --statistics Sum


# Put Metric Data
aws cloudwatch put-metric-data --namespace "DCL/DEMO" --metric-name Ping --value 1 --timestamp `date -Iseconds`
aws cloudwatch 
