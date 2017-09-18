cd C:\dclsoftware\clients\GK\awsdemos\AwsDeveloper\scripts\demos\ch06-kinesis

# Create Stream
aws kinesis create-stream --stream-name DevDemoStream --shard-count 2

# Describe Stream
aws kinesis describe-stream --stream-name DevDemoStream

# Describe Limits
aws kinesis describe-limits

# Put Records
aws kinesis put-record --stream-name DevDemoStream --partition-key a --data '{"SensorId":1, "Time":0, "Reading":20}'
aws kinesis put-record --stream-name DevDemoStream --partition-key b --data '{"SensorId":2, "Time":0, "Reading":21}'

aws kinesis put-record --stream-name DevDemoStream --partition-key a --data '{"SensorId":1, "Time":1, "Reading":20}'
aws kinesis put-record --stream-name DevDemoStream --partition-key b --data '{"SensorId":2, "Time":1, "Reading":22}'

aws kinesis put-record --stream-name DevDemoStream --partition-key a --data '{"SensorId":1, "Time":2, "Reading":20}'
aws kinesis put-record --stream-name DevDemoStream --partition-key b --data '{"SensorId":2, "Time":2, "Reading":23}'

# Put Records with Explicit Hash Key
aws kinesis put-record --stream-name DevDemoStream --partition-key b --explicit-hash-key 0 --data '{"SensorId":1, "Time":3, "Reading":20}'
aws kinesis put-record --stream-name DevDemoStream --partition-key a --explicit-hash-key 170141183460469231731687303715884105728 --data '{"SensorId":2, "Time":3, "Reading":24}'

# Get Records
aws kinesis get-shard-iterator  --stream-name DevDemoStream --shard-id shardId-000000000000 --shard-iterator-type TRIM_HORIZON --output text
aws kinesis get-shard-iterator  --stream-name DevDemoStream --shard-id shardId-000000000001 --shard-iterator-type TRIM_HORIZON --output text

aws kinesis get-records --shard-iterator <from shardId-000000000000>
aws kinesis get-records --shard-iterator <from shardId-000000000001>

aws kinesis get-records --shard-iterator <>

#Delete Stream

aws kinesis delete-stream --stream-name DevDemoStream


# See KinesisStreamsDemo.java for code to compute MD5 for keys a,b
#
# a -> 16955237001963240173058271559858726497
# b -> 195289424170611159128911017612795795343
# s -> 170141183460469231731687303715884105728
