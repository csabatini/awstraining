// Copyright 2017 Amazon Web Services, Inc. or its affiliates. All rights reserved.

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.services.kinesis.clientlibrary.interfaces.IRecordProcessorFactory;
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.InitialPositionInStream;
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.KinesisClientLibConfiguration;
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.Worker;
import com.amazonaws.services.kinesis.model.Record;

import java.nio.ByteBuffer;

public class Solution {

//DONE
//  public static AmazonKinesisClient createKinesisClient(AWSCredentials credentials, Region region) {
//    AmazonKinesisClient kclient = new AmazonKinesisClient(credentials);
//    kclient.setRegion(region);
//    return kclient;
//  }

// DONE
//  public static void createStream(AmazonKinesisClient kinesis, String streamName, int shardCount) {
//    CreateStreamRequest createStreamRequest = new CreateStreamRequest();
//    createStreamRequest.setStreamName(streamName);
//    createStreamRequest.setShardCount(shardCount);
//    kinesis.createStream(createStreamRequest);
//  }

// DONE
//    public static String getStreamStatus(AmazonKinesisClient kinesis, String streamName) {
//        String streamStatus = null;
//        DescribeStreamRequest describeStreamRequest = new DescribeStreamRequest();
//        describeStreamRequest.setStreamName(streamName);
//        DescribeStreamResult describeStreamResponse = kinesis.describeStream(describeStreamRequest);
//        streamStatus = describeStreamResponse.getStreamDescription().getStreamStatus();
//        return streamStatus;
//    }

// DONE
//    public static KinesisProducerConfiguration createKinesisProducerConfig(Region region) {
//        KinesisProducerConfiguration config = new KinesisProducerConfiguration();
//        config.setRegion(region.getName());
//        return config;
//    }

// DONE
//    public static KinesisProducer createKinesisProducer(KinesisProducerConfiguration config) {
//        KinesisProducer kinesisProducer = new KinesisProducer(config);
//        return kinesisProducer;
//    }

// DONE
//    public static ListenableFuture<UserRecordResult> addUserRecordToStream(
//            String streamName, KinesisProducer kinesisProducer, SensorData sensorData) {
//        ListenableFuture<UserRecordResult> future =
//                kinesisProducer.addUserRecord(streamName, sensorData.sensorId, sensorData.data);
//        return future;
//    }

    public static KinesisClientLibConfiguration createKinesisConfig(
            String appName,
            String streamName,
            AWSCredentialsProvider credentialsProvider,
            String workerId,
            InitialPositionInStream position,
            Region region) {
        KinesisClientLibConfiguration kinesisClientLibConfiguration =
                new KinesisClientLibConfiguration(appName, streamName, credentialsProvider, workerId);
        kinesisClientLibConfiguration.withInitialPositionInStream(position);
        kinesisClientLibConfiguration.withRegionName(region.getName());
        return kinesisClientLibConfiguration;
    }

    public static Worker createWorker(KinesisClientLibConfiguration kinesisClientLibConfiguration) {
        IRecordProcessorFactory recordProcessorFactory = new SensorRecordProcessorFactory();
        Worker worker = new Worker(recordProcessorFactory, kinesisClientLibConfiguration);
        return worker;
    }

    public static ByteBuffer getRecordData(Record record) {
        return record.getData();
    }
}
