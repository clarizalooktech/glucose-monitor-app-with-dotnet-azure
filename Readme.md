
# Glucose Monitor App

A full-stack cloud-native application for tracking and managing blood glucose levels, deployed on Azure with complete CI/CD automation.

## 🌐 Live Demo

- **Frontend:** https://glucosemonitoruistorage.z31.web.core.windows.net/
- **Backend API:** https://glucose-monitor-api.azurewebsites.net/api/glucose

## 📋 Project Overview

- **Functionality**: Track and monitor blood glucose levels with fasting and postprandial measurements
- **Frontend**: React application with responsive UI
- **Backend**: .NET 8.0 Web API with RESTful endpoints
- **Infrastructure**: Fully automated deployment on Azure using Terraform (Infrastructure as Code)
- **Containerization**: Docker containers stored in Azure Container Registry (ACR)
- **Deployment**:
  - .NET API deployed to Azure App Service (Linux)
  - React UI deployed to Azure Storage Static Website
- **CI/CD**: Complete GitHub Actions workflow with automated testing and deployment

### DevOps Principles Demonstrated:
1. **Infrastructure as Code (IaC)**:
Terraform is used to provision and manage the Azure infrastructure. This allows for consistent and repeatable deployments, version control of infrastructure, and reduced manual configuration.

2. **Continuous Integration/Continuous Deployment (CI/CD)**:
The github workflow outlines CI/CD pipeline on deploying the web app and infrastructure.

3. **Containerization**:
Docker is used to package the .NET backend into a container. This provides consistency across different environments, simplifies deployment, and allows for scalability.
Azure Container Registry(ACR) is used to store the docker images.

3. **Automation**:
The CI/CD pipelines automate the build, test, and deployment processes, reducing manual effort and potential errors.
Terraform automates the creation of the infrastructure.


![DevOps Workflow Diagram](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/workflow-diagram.jpg)

## 🛠️ Key Technologies

| Category | Technology |
|----------|-----------|
| Frontend | React 19, Axios, CSS |
| Backend | .NET 8.0, ASP.NET Core Web API |
| Containerization | Docker, Azure Container Registry |
| Infrastructure | Terraform, Azure Resource Manager |
| CI/CD | GitHub Actions, Azure CLI |
| Cloud Platform | Microsoft Azure |
| Authentication | Azure OIDC with Federated Credentials |
| Hosting | Azure App Service, Azure Storage Static Website |

## Prerequisites

- Node.js and npm
- .NET SDK
- Terraform
- Azure account

## 🚀 Deployment to Azure

### Important Note for Azure for Students
Due to Azure for Students subscription limitations, some resources must be created manually via Azure CLI before running Terraform.

### Step 1: Create Resource Group
```bash
az group create \
  --name glucose-monitor-rg \
  --location japanwest
```

### Step 2: Create App Service Plan
```bash
az appservice plan create \
  --name glucose-monitor-plan \
  --resource-group glucose-monitor-rg \
  --location japanwest \
  --is-linux \
  --sku B1
```

### Step 3: Verify Resources
```bash
az resource list --resource-group glucose-monitor-rg -o table
```

### Step 4: Configure GitHub Secrets

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

- `AZURE_CLIENT_ID`: Service principal client ID
- `AZURE_TENANT_ID`: Azure AD tenant ID
- `AZURE_SUBSCRIPTION_ID`: Azure subscription ID
- `TF_VAR_RESOURCE_GROUP_NAME`: glucose-monitor-rg
- `TF_VAR_ACR_NAME`: Your ACR name
- `TF_VAR_LOCATION`: japanwest
- `TF_VAR_APP_NAME`: glucose-monitor
- `TF_VAR_acr_name`: Your ACR name (lowercase)
- `TF_VAR_resource_group_name`: glucose-monitor-rg

### Step 5: Deploy via CI/CD

1. Make a change to your code
2. Commit and push to the `feature/setting-azure-infrastructure` branch
3. GitHub Actions will automatically:
   - Provision infrastructure with Terraform
   - Build and push Docker images
   - Deploy the API to App Service
   - Build and deploy the React UI to Azure Storage

### Step 6: Configure CORS (First Deployment Only)
```bash
az webapp cors add \
  --name glucose-monitor-api \
  --resource-group glucose-monitor-rg \
  --allowed-origins "https://glucosemonitoruistorage.z31.web.core.windows.net"
```

## 💻 Local Development

### Setting Up the Frontend

1. Navigate to the `src/ui` directory:
  ```
  cd src/ui
  ```

2. Install the dependencies:
  ```
  npm install
  ```

3. Start the development server:
  ```
  npm start
  ```
4. The app will run in development mode. Open http://localhost:3000 to view it in your browser.


### Setting Up the Backend
1. Navigate to the `src/api` directory:
  ```
  cd src/api
  ```

2. Restore the .NET dependencies:
  ```
  dotnet restore
  ```

3. Run the backend server:
  ```
  dotnet run
  ```

4. The API will be available at http://localhost:5000.

### Deploying to Azure with Terraform
1. Navigate to the Terraform configuration directory:
   ```
   cd infra/terraform
   ```
2. Initialize Terraform:
   ```
   terraform init
   ```

3. Plan the deployment:
   ```
   terraform plan
   ```

4. Apply the deployment:
   ```
   terraform apply
   ```

5. Follow the prompts to confirm the deployment. This will deploy the application to Azure.

6. Destroy resources
```
terraform destroy
```

## Screenshots
1. Front-end

![Glucose Monitor UI](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/front-end.png)

2. Back-End

3. CI/CD Pipeline - Docker Build & Push

![Cicd Build and Push Image to Azure Container Registry](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/cicd-build-and-push-image.PNG)

4. Terraform - Local Testing

![Terraform Init](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/terraform-init-successful.png)
![Terraform Plan](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/terraform-plan-successful.png)

4. Terraform (during deployment to Azure)

![Terraform Apply](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/cicd-terraform-apply.PNG)

5. Azure Deployed Resources

Image Pushed in the Container Registry with the Backend Api
![Image Pushed in the Container Registry with the Backend Api](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/After-docker-push-image-in-Acr-Container-Registry.PNG)

How Resource Group looks like in Azure Console
![How Resource Group looks like in Azure Console](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/Creation-of-resources-in-resourcegroup.jpg)

Checking Error Logs on the App Service Api
![Checking Error Logs on the App Service Api](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/Checking-error-log-app-service-api.jpg)

### Project Structure
```
├── .github/
│   └── workflows/
│       └── deploy.yml               # CI/CD Pipeline (GitHub Actions)
│
├── src/
│   ├── api/                         # .NET Backend API
│   │   ├── bin/                     # Build output (ignored in Git)
│   │   ├── obj/                     # Build metadata (ignored in Git)
│   │   ├── Controllers/             # API Controllers (GlucoseController.cs)
│   │   ├── Models/                  # Data Models (GlucoseReading.cs)
│   │   ├── Data/                    # Database Context (GlucoseDbContext.cs)
│   │   ├── Properties/
│   │   │   ├── launchSettings.json
│   │   ├── appsettings.json         # App configuration
│   │   ├── Program.cs               # Entry point
│   │   ├── api.csproj               # Project file
│   │   ├── Dockerfile               # API Dockerfile
│   │   ├── README.md                # API documentation
│   │   ├── Startup.cs
│   │
│   ├── ui/                          # React Frontend
│       ├── src/                     # React source files
│       │   ├── App.css
│       │   ├── App.js
│       │   ├── App.test.js
│       │   ├── index.css
│       │   ├── index.css
│       │   ├── logo.svg
│       │   ├── reportWebVitals.js
│       │   ├── index.css
│       │   ├── setupTests.js
│       ├── public
│       │   ├── favicon.ico
│       │   ├── index.html
│       │   ├── logo192.png
│       │   ├── logo512.png
│       │   ├── manifest.json
│       │   ├── robots.txt
│       ├── .eslintrc.js
│       ├── .gitignore
│       ├── package-lock.json
│       ├── package.json
│       ├── Dockerfile               # Frontend Dockerfile
│       └── README.md                # Frontend documentation
│
├── infra/                           # Infrastructure Setup
│   ├── terraform/                   # Terraform Configs
│   │   ├── main.tf                  # Main Terraform file
│   │   ├── variables.tf             # Input variables
│   │   ├── outputs.tf               # Output values
│   │   ├── providers.tf             # Azure provider setup
│   │   ├── app-service.tf           # Defines Azure App Service
│   │   ├── sql-database.tf          # Defines Azure SQL (Serverless)
│   │   ├── acr.tf                   # Azure Container Registry
│   │   ├── static-web-app.tf        # Azure Static Web Apps for React
│   │   ├── networking.tf            # Networking & security setup
│   │   ├── terraform.tfvars         # Variable values (excluded from Git)
│   │   └── backend.tf               # (If using remote Terraform state)
│   └── README.md                    # Infra documentation
│
├── test/                            # Unit and Integration Tests
│   ├── api-tests/                   # API Tests
│   ├── frontend-tests/              # React Frontend Tests (Jest, Cypress)
│   ├── load-tests/                  # Performance Tests
│   └── README.md                    # Test documentation
│
├── Dockerfile                       # Root Dockerfile
├── docker-compose.yml               # Compose file for services
├── README.md                        # Documentation
└── .gitignore                       # Git Ignore file

```

## 💰 Cost Estimation

Running this application on Azure for Students:

- **App Service Plan (B1)**: ~$0.075/hour (~$55/month)
- **Container Registry (Basic)**: ~$0.007/hour (~$5/month)
- **Storage Account**: ~$0.0004/hour (~$0.30/month)

**Total**: ~$60/month (well within the $100 Azure for Students credit)

## 🔒 Security Features

- OIDC authentication (no stored credentials)
- Managed identities for secure resource access
- CORS configuration for cross-origin requests
- TLS 1.2 minimum encryption
- FTPS disabled (secure transfers only)

## 🎯 Future Enhancements

- [ ] Add Azure SQL Database for persistent storage
- [ ] Implement user authentication (Azure AD B2C)
- [ ] Add automated testing in CI/CD pipeline
- [ ] Set up Application Insights for monitoring
- [ ] Implement blue-green deployment strategy
- [ ] Add database migrations