# Get the managed identity principal ID from the App Service
PRINCIPAL_ID=$(az webapp identity show --name $APP_SERVICE_NAME --resource-group $RESOURCE_GROUP --query principalId -o tsv)

# Assign the AcrPull role to the App Service's managed identity
az role assignment create \
  --assignee $PRINCIPAL_ID \
  --role "AcrPull" \
  --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ContainerRegistry/registries/$ACR_NAME"

echo "ACR Pull role assigned successfully to $APP_SERVICE_NAME"