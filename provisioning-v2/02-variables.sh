#!/bin/bash

#Set some variables
# Any vars with REPLACE value you need to update via direct assignment or execute the instructed CLI commands

# - Project Variables
# - Azure Subscription Information
# - Resource groups
# - Azure Monitor
# - Networking
# - AAD Integration
# - ACR
# - Application Gateway
# - Azure Firewall
# - AKS Cluster
# - Public IPs

### Project Variables
# Have a project code (short like 2 or 3 letters)
# I selected "cap" for crowd-analytics-platform project I worked on
PROJECT_CODE="cap"
# Set the environment that this deployment represent (dev, qa, prod,...)
ENVIRONMENT="dev"
echo export PROJECT_CODE=$PROJECT_CODE >> ~/.bashrc
echo export ENVIRONMENT=$ENVIRONMENT >> ~/.bashrc

# Prefix is a combination of project and environment
PREFIX="${ENVIRONMENT}${PROJECT_CODE}"
echo export PREFIX=$PREFIX >> ~/.bashrc

# Primary location
LOCATION="westeurope"
# Location code will be used to setup multi-region resources
LOCATION_CODE="weu"
echo export LOCATION=$LOCATION >> ~/.bashrc
echo export LOCATION_CODE=$LOCATION_CODE >> ~/.bashrc

# Azure subscription vars
SUBSCRIPTION_ID="REPLACE"
TENANT_ID="REPLACE"
echo export SUBSCRIPTION_ID=$SUBSCRIPTION_ID >> ~/.bashrc
echo export TENANT_ID=$TENANT_ID >> ~/.bashrc

### Resource groups
RG_AKS="${PREFIX}-aks-${LOCATION_CODE}"
RG_AKS_NODES="${RG}-nodes-${LOCATION_CODE}";
RG_INFOSEC="${PREFIX}-rg-infosec-${LOCATION_CODE}"
RG_SHARED="${PREFIX}-rg-shared-${LOCATION_CODE}"

echo export RG_AKS=$RG_AKS >> ~/.bashrc
echo export RG_AKS_NODES=$RG_AKS_NODES >> ~/.bashrc
echo export RG_INFOSEC=$RG_INFOSEC >> ~/.bashrc
echo export RG_SRE=$RG_SRE >> ~/.bashrc

### Azure Monitor
echo export WORKSPACE_NAME="${PREFIX}-logs" >> ~/.bashrc

# Creating Application Insights for each app
echo export APP_NAME="${PREFIX}-REPLACE-insights-${LOCATION_CODE}" >> ~/.bashrc
echo export APP_APPINSIGHTS_KEY=REPLACE >> ~/.bashrc

### Virtual networks
echo export PROJ_VNET_NAME="${PREFIX}-vnet-${LOCATION_CODE}" >> ~/.bashrc
echo export HUB_EXT_VNET_NAME="hub-ext-vnet-${LOCATION_CODE}" >> ~/.bashrc
# HUB_INT_VNET_NAME can be added to introduce on-premise connectivity

echo export PROJ_VNET_ADDRESS_SPACE="10.165.10.0/23 10.165.12.0/22 10.165.16.0/21" >> ~/.bashrc
echo export HUB_EXT_VNET_ADDRESS_SPACE="10.165.4.0/22 10.165.8.0/23" >> ~/.bashrc

# AKS primary subnet
echo export AKS_SUBNET_NAME="${PREFIX}-aks" >> ~/.bashrc

# AKS exposed services subnet
echo export SVC_SUBNET_NAME="${PREFIX}-svc" >> ~/.bashrc

# Application gateway subnet
echo export AGW_SUBNET_NAME="${PREFIX}-agw" >> ~/.bashrc

# Azure Firewall Subnet name must be AzureFirewallSubnet
echo export FW_SUBNET_NAME="AzureFirewallSubnet" >> ~/.bashrc

# Virutal nodes subnet (for serverless burst scaling)
echo export VN_SUBNET_NAME="${PREFIX}-vn" >> ~/.bashrc

# Azure API Management Subnet
echo export APIM_SUBNET_NAME="${PREFIX}-apim" >> ~/.bashrc
echo export APIM_HOSTED_SUBNET_NAME="${PREFIX}-apim-hosted" >> ~/.bashrc

# Self hosted agents
echo export DEVOPS_AGENTS_SUBNET_NAME="${PREFIX}-devops" >> ~/.bashrc

# IP ranges for each subnet (for simplicity some are created with /24)
# Always carefully plan your network size based on expected workloads
# Sizing docs: https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni

# This /21 size would support around 60 node cluster (given that 30 pods/cluster is used)
echo export AKS_SUBNET_IP_PREFIX="10.165.10.0/21" >> ~/.bashrc
echo export VN_SUBNET_IP_PREFIX="10.165.16.0/22" >> ~/.bashrc
echo export SVCS_UBNET_IP_PREFIX="10.165.20.0/24" >> ~/.bashrc
echo export APIM_HOSTED_SUBNET_IP_PREFIX="10.165.21.0/24" >> ~/.bashrc

echo export FW_SUBNET_IP_PREFIX="10.165.4.0/24" >> ~/.bashrc
echo export AGW_SUBNET_IP_PREFIX="10.165.5.0/24" >> ~/.bashrc
echo export APIM_SUBNET_IP_PREFIX="10.165.6.0/24" >> ~/.bashrc
echo export DEVOPS_AGENTS_SUBNET_IP_PREFIX="10.165.7.0/24" >> ~/.bashrc

### AAD Integration

# AKS Service Principal
AKS_SP_NAME="${PREFIX}-aks-sp-${LOCATION_CODE}"
AKS_SP_ID="REPLACE"
AKS_SP_PASSWORD="REPLACE"
echo export AKS_SP_NAME=$AKS_SP_NAME >> ~/.bashrc
echo export AKS_SP_ID=$AKS_SP_ID >> ~/.bashrc
# echo export AKS_SP_PASSWORD=$AKS_SP_PASSWORD >> ~/.bashrc

# AAD Enabled Cluster
SERVER_APP_ID=REPLACE
echo export SERVER_APP_ID=$SERVER_APP_ID >> ~/.bashrc
SERVER_APP_SECRET=REPLACE
echo export SERVER_APP_SECRET=$SERVER_APP_SECRET >> ~/.bashrc
CLIENT_APP_ID=REPLACE
echo export CLIENT_APP_ID=$CLIENT_APP_ID >> ~/.bashrc

# AKS Pod Identity
PODS_MANAGED_IDENTITY_NAME="${PREFIX}-pods-default-identity-${LOCATION_CODE}"
PODS_MANAGED_IDENTITY_CLIENTID=REPLACE
PODS_MANAGED_IDENTITY_ID=REPLACE
PODS_MANAGED_IDENTITY_SP_ID=REPLACE
# Saving the MSI for later use
echo export PODS_MANAGED_IDENTITY_NAME=$PODS_MANAGED_IDENTITY_NAME >> ~/.bashrc
echo export PODS_MANAGED_IDENTITY_CLIENTID=$PODS_MANAGED_IDENTITY_CLIENTID >> ~/.bashrc
echo export PODS_MANAGED_IDENTITY_ID=$PODS_MANAGED_IDENTITY_ID >> ~/.bashrc
echo export PODS_MANAGED_IDENTITY_SP_ID=$PODS_MANAGED_IDENTITY_SP_ID >> ~/.bashrc

# AGIC Managed Identity
AGIC_MANAGED_IDENTITY_NAME="${PREFIX}-agic-identity-${LOCATION_CODE}"
echo export AGIC_MANAGED_IDENTITY_NAME=$AGIC_MANAGED_IDENTITY_NAME >> ~/.bashrc
# or use Service Principal
AGIC_SP_NAME="${PREFIX}-agic-sp-${LOCATION_CODE}"
AGIC_SP_ID=REPLACE
AGIC_SP_Password=REPLACE
echo export AGIC_SP_NAME=$AGIC_SP_NAME >> ~/.bashrc
echo export AGIC_SP_ID=$AGIC_SP_ID >> ~/.bashrc
echo export AGIC_SP_Password=$AGIC_SP_Password >> ~/.bashrc

### ACR
CONTAINER_REGISTRY_NAME="${PREFIX}${LOCATION_CODE}acr"
echo export CONTAINER_REGISTRY_NAME=$CONTAINER_REGISTRY_NAME >> ~/.bashrc

### Application Gateway
AGW_NAME="${PREFIX}-agw-${LOCATION_CODE}"
AGW_RESOURCE_ID=REPLACE
echo export AGW_NAME=$AGW_NAME >> ~/.bashrc
echo export AGW_RESOURCE_ID=$AGW_RESOURCE_ID >> ~/.bashrc

### Azure Firewall
FW_NAME="${PREFIX}-fw-${LOCATION_CODE}"
FW_IPCONFIG_NAME="${FW_NAME}-ip-config"
FW_UDR=$FW_NAME-udr
FW_UDR_ROUTE_NAME=$FW_IPCONFIG_NAME-route
echo export FW_NAME=$FW_NAME >> ~/.bashrc
echo export FW_IPCONFIG_NAME=$FW_IPCONFIG_NAME >> ~/.bashrc
echo export FW_UDR=$FW_UDR >> ~/.bashrc
echo export FW_UDR_ROUTE_NAME=$FW_UDR_ROUTE_NAME >> ~/.bashrc

### AKS Cluster
AKS_CLUSTER_NAME="${PREFIX}-aks-${LOCATION_CODE}"
AKS_VERSION=REPLACE
AKS_DEFAULT_NODEPOOL="${PREFIX}-default-np"
AKS_RESOURCE_ID=REPLACE
AKS_FQDN=REPLACE
echo export AKS_CLUSTER_NAME=$AKS_CLUSTER_NAME >> ~/.bashrc
echo export AKS_VERSION=$AKS_VERSION >> ~/.bashrc
echo export AKS_DEFAULT_NODEPOOL=$AKS_DEFAULT_NODEPOOL >> ~/.bashrc
echo export AKS_RESOURCE_ID=$AKS_RESOURCE_ID >> ~/.bashrc
echo export AKS_FQDN=$AKS_FQDN >> ~/.bashrc

# If you are using Windows Containers support, you need the following
WIN_USER="localwinadmin"
WIN_PASSWORD="P@ssw0rd1234"
WIN_NODEPOOL="${PREFIX}-win-np"
echo export WIN_USER=$WIN_USER >> ~/.bashrc
echo export WIN_PASSWORD=$WIN_PASSWORD >> ~/.bashrc
echo export WIN_NODEPOOL=$WIN_NOODEPOOL >> ~/.bashrc

echo "Variables Scripts Execution Completed"

### Public IPs
AKS_PIP_NAME="${AKS_CLUSTER_NAME}-pip"
AGW_PIP_NAME="${AGW_NAME}-pip"
FW_PIP_NAME="${FW_NAME}-pip"
echo export AKS_PIP_NAME=$AKS_PIP_NAME >> ~/.bashrc
echo export AGW_PIP_NAME=$AGW_PIP_NAME >> ~/.bashrc
echo export FW_PIP_NAME=$FW_PIP_NAME >> ~/.bashrc

# Reload the .bashrc variables
source ~/.bashrc