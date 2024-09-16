#!/bin/bash

source variables.inc

# Create the Spanner instance
gcloud spanner instances create $SPANNER_INSTANCE_ID \
--config=regional-${LOCATION} \
--description="spanner AI retail demo" \
--nodes=1


# create a database in the instance

gcloud spanner databases create $SPANNER_DATABASE \
 --instance=$SPANNER_INSTANCE_ID


