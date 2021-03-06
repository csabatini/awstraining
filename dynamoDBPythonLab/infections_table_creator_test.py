# Copyright 2017 Amazon Web Services, Inc. or its affiliates. All rights
# reserved.

import unittest
import boto3
import utils
import warnings

TABLE_NAME = utils.LAB_S3_INFECTIONS_TABLE_NAME
TOTAL_INFECTIONS_RECORDS = 1000


class InfectionsTableCreatorTest(unittest.TestCase):

    def test_create_table(self):
        warnings.simplefilter("ignore", ResourceWarning)
        rval = utils.is_table_active(TABLE_NAME)
        self.assertTrue(rval)

if __name__ == '__main__':
    unittest.main()
