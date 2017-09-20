# Copyright 2017 Amazon Web Services, Inc. or its affiliates. All rights
# reserved.

import memcache
import sys
import utils as dynamoDB_manager
import solution
import logging

# DONE
# STUDENT TODO 1: Set the cluster configuration endpoint
CLUSTER_CONFIG_ENDPOINT = "qls-el-16rmxoe07lj3t.ou9bdw.cfg.usw2.cache.amazonaws.com:11211"


# Welcome to the AWS Python SDK! Let's build a Pharmaceutical drug listing!



# Returns pharmaceutical usage information for the given drug.
# Attempts to retrieve item from cache.
# If the item is not found in cache, retrieves the information from
# DynamoDB and updates cache.


def get_pharma_info(drugName):
    # Retrieves pharmaceutical usage information from cache for the given drug
    # name. Set the cache if not available
    pharma_info = None
    try:
        mclient = create_memcached_client()
        pharma_info = get_from_cache(mclient, drugName)
        if not pharma_info:
            pharma_info = dynamoDB_manager.get_info(drugName)
            if not pharma_info:
                print("Given drug name not available in the table")
                return None
            store_in_cache(mclient, drugName, pharma_info)
            pharma_info = get_from_cache(mclient, drugName)
            if not pharma_info:
                print("Unable to set the cache for the given DrugName:{0}".format(drugName))
            else:
                print("Pulled info from cache for the given DrugName:{0}".format(drugName))
    except Exception as err:
        logging.exception("Error")
    return pharma_info


def setup():
    dynamoDB_manager.setup()


def create_memcached_client():
    """Create a client for Memcached

    Keyword arguments:
    memcache -- the memcache object
    clusterEndpoint -- memcached cluster endpoint
    """
    # STUDENT TODO 2: Replace the solution with your own code
    # return solution.create_memcached_client(memcache, clusterEndpoint)
    return memcache.Client([CLUSTER_CONFIG_ENDPOINT], debug=0)


def get_from_cache(client, key):
    """Gets a value from the cache

    Keyword arguments:
    client -- memcached client
    key -- key of value to get from cache
    """

    # STUDENT TODO 3: Replace the solution with your own code
    # return solution.get_from_cache(client, key)
    pharma_info = None
    try:
        pharma_info = client.get(key)
    except Exception as err:
        logging.exception("Error getting key: {}".format(key))
    return pharma_info


def store_in_cache(client, key, value):
    """Store a value in the cache

    Keyword arguments:
    client -- memcached client
    key -- key to store in cache
        value -- value to store in cache
    """

    # STUDENT TODO 4: Replace the solution with your own code
    # solution.store_in_cache(client, key, value)
    try:
        client.set(key, value, 3600)
    except Exception as err:
        logging.exception("Error setting key: {}".format(key))


def main(drugName):
    # Setting up DynamoDB
    setup()
    pharma_info = get_pharma_info(drugName)
    return pharma_info


if __name__ == '__main__':
    drugName = 'Octinoxate'
    if len(sys.argv) > 1:
        drugName = sys.argv[1]
    pharma_info = main(drugName)
    print("Retrieved pharmaceutical information:")
    print("Given DrugName: {0}".format(drugName))
    print("Retrieved DrugInfo: {0}".format(str(pharma_info)))
