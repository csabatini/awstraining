# Copyright 2017 Amazon Web Services, Inc. or its affiliates. All rights
# reserved.

import json
import logging

import utils
from utils import session

# The SNSPublisher class publishes messages to SNS topics
EMAIL_SUBJECT = "Status of pharmaceuticals order."
EMAIL_MESSAGE = "Your pharmaceutical supplies will be shipped 5 business days from the date of order."
ORDER_DETAILS = "Ibuprofen, Acetaminophen"

# DONE
# STUDENT TODO 1: Set ARN for SNS topic for email messages
TOPIC_ARN_EMAIL = "arn:aws:sns:us-west-2:240266347339:EmailSNSTopic"

# DONE
# STUDENT TODO 2: Set ARN for SNS topic for order messages
TOPIC_ARN_ORDER = "arn:aws:sns:us-west-2:240266347339:OrderSNSTopic"


def publish_email_msg(
        topicArn=TOPIC_ARN_EMAIL,
        emailMesg=EMAIL_MESSAGE,
        emailSubj=EMAIL_SUBJECT):
    sns_client = session.client('sns')
    publish_email(sns_client, topicArn, emailMesg, emailSubj)
    print("Email topic published")


def publish_order_msgs(topicArn=TOPIC_ARN_ORDER, orderDetails=ORDER_DETAILS):
    sns_client = session.client('sns')
    for i in range(1, utils.NUM_MESSAGES + 1):
        orderDict = {
            'orderId': i,
            'orderDate': "2015/10/%d" % i,
            'orderDetails': orderDetails}
        porder = utils.Order(orderDict)
        print("Publishing order to SNS topic:", repr(porder))
        jsonStr = json.dumps(porder, default=utils.jdefault, indent=4)  # convert_order_to_json(porder)
        publish_order(sns_client, topicArn, jsonStr)
        print("Order topic published")


def publish_msgs():
    publish_email_msg()
    publish_order_msgs()


def publish_email(sns_client, topic_arn, email_mesg, email_subj):
    """Sends the email

    Keyword arguments:
    sns -- SNS service resource
    topicArn -- ARN for the topic
        emailSubj -- Email subject
        emailMesg -- Email message
    """

    # STUDENT TODO 3: Replace the solution with your own code
    # solution.publish_email(sns, topic_arn, email_mesg, email_subj)
    sns_client.publish(TopicArn=topic_arn, Message=email_mesg, Subject=email_subj)


# DONE
# def convert_order_to_json(porder):
#     """Return the order in JSON format
#
#     Keyword arguments:
#     porder -- the order
#     """

    # STUDENT TODO 4: Replace the solution with your own code
    # return solution.convert_order_to_json(porder)


def publish_order(sns_client, topic_arn, json_order):
    """Sends the order message

    Keyword arguments:
    sns -- SNS service resource
        topicArn -- ARN for the topic
        jsonStr -- the order in JSON format
    """

    # STUDENT TODO 5: Replace the solution with your own code
    # solution.publish_order(sns, topic_arn, json_order)
    sns_client.publish(TopicArn=topic_arn, Message=json_order)


def main():
    try:
        publish_msgs()
    except Exception as err:
        logging.exception("Error Message ")


if __name__ == '__main__':
    main()
