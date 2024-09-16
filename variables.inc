#!/bin/bash

LOCATION=us-central1

SPANNER_INSTANCE_ID=retail-demo
SPANNER_DATABASE=cymbal-bikes

PROJECT_ID=`gcloud config get-value project`
BILLING_ACCOUNT=`gcloud billing projects describe $PROJECT_ID --format='value(billingAccountName)' | sed 's/^billingAccounts\///'`
#USER_EMAIL=`gcloud config get account`

