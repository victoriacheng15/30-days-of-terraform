#!/bin/bash

# A simple script to provision the Storage Account needed for the Remote State.
# In a real enterprise, this is often created once manually or by a "Root" pipeline.

RESOURCE_GROUP_NAME="rg-tofu-state-mgmt"
STORAGE_ACCOUNT_NAME="tofustate$RANDOM" # Storage names must be unique!
CONTAINER_NAME="tfstate"
LOCATION="westus2"

echo "Creating Resource Group: $RESOURCE_GROUP_NAME..."
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

echo "Creating Storage Account: $STORAGE_ACCOUNT_NAME..."
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

echo "Creating Storage Container: $CONTAINER_NAME..."
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

echo "----------------------------------------------------"
echo "Backend Configuration Details:"
echo "----------------------------------------------------"
echo "resource_group_name  = \"$RESOURCE_GROUP_NAME\""
echo "storage_account_name = \"$STORAGE_ACCOUNT_NAME\""
echo "container_name       = \"$CONTAINER_NAME\""
echo "key                  = \"terraform.tfstate\""
echo "----------------------------------------------------"
