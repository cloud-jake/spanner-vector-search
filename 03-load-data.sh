#!/bin/bash

source variables.inc

# Create the Cymbal schema

gcloud spanner databases ddl update $SPANNER_DATABASE --instance=$SPANNER_INSTANCE_ID \
--ddl="CREATE TABLE products ( \
categoryId INT64 NOT NULL, \
productId INT64 NOT NULL, \
productName STRING(MAX) NOT NULL, \
productDescription STRING(MAX) NOT NULL, \
productDescriptionEmbedding ARRAY<FLOAT32>, \
createTime TIMESTAMP NOT NULL OPTIONS ( \
allow_commit_timestamp = true \
), \
inventoryCount INT64 NOT NULL, \
priceInCents INT64, \
) PRIMARY KEY(categoryId, productId);"


# Create Models

## Create Embeddings Model
gcloud spanner databases ddl update $SPANNER_DATABASE --instance=${SPANNER_INSTANCE_ID} \
--ddl="CREATE MODEL EmbeddingsModel \
INPUT(content STRING(MAX)) \
OUTPUT(embeddings STRUCT<statistics STRUCT<truncated BOOL, token_count FLOAT32>, values ARRAY<FLOAT32>>) \
REMOTE OPTIONS ( \
endpoint = "'"'"//aiplatform.googleapis.com/projects/${PROJECT_ID}/locations/${LOCATION}/publishers/google/models/text-embedding-004"'"'" \
);"


## Create LLM Model
gcloud spanner databases ddl update $SPANNER_DATABASE --instance=${SPANNER_INSTANCE_ID} \
--ddl="CREATE MODEL LLMModel \
INPUT(prompt STRING(MAX)) \
OUTPUT(content STRING(MAX)) \
REMOTE OPTIONS ( \
endpoint = "'"'"//aiplatform.googleapis.com/projects/${PROJECT_ID}/locations/${LOCATION}/publishers/google/models/gemini-pro"'"'", \
default_batch_size = 1 \
);"

# Load Data

