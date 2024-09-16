#!/bin/bash

PROJECT_ID=`gcloud config get-value project`
BILLING_ACCOUNT=`gcloud billing projects describe $PROJECT_ID --format='value(billingAccountName)' | sed 's/^billingAccounts\///'`
#USER_EMAIL=`gcloud config get account`

gcloud services enable billingbudgets.googleapis.com --project=$PROJECT_ID

# create a billing budget for $10 with various alerting thresholds
gcloud billing budgets create \
  --billing-account=$BILLING_ACCOUNT \
  --display-name "Budget:${PROJECT_ID}" \
  --budget-amount=10 \
  --filter-projects="projects/$PROJECT_ID" \
  --threshold-rule=percent=0.50 \
  --threshold-rule=percent=0.75 \
  --threshold-rule=percent=0.90 \
  --threshold-rule=percent=1.00 \
  --threshold-rule=percent=2.00 \
  --threshold-rule=percent=5.00 \
  --threshold-rule=percent=10.00 
