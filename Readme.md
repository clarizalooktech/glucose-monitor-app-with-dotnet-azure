
# Glucose Monitor App

This project is a Glucose Monitor App with a frontend built using React and a backend built using .NET. The application will be deployed using Terraform in Azure.

### Project Overview
- **Functionality**: A Glucose Monitor App designed to track and manage blood glucose levels.
- **Frontend**: Built using React, providing a user-friendly interface.
- **Backend**: Developed with .NET, handling data processing, storage, and API interactions.
- **Infrastructure**: Deployed on Azure using Terraform, enabling Infrastructure as Code (IaC).
- **Containerization**: The .NET backend is containerized using Docker and pushed to Azure Container Registry (ACR).
- **Deployment**:
  - The .NET API is deployed to Azure App Service.
  - The React UI is deployed to Azure Static Web Apps.
- **DevOps Focus**: Emphasizes automation, CI/CD, and infrastructure management.

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

### Key Technologies:

- React: Frontend framework.
- .NET: Backend framework.
- Docker: Containerization platform.
- Azure Container Registry (ACR): Container image registry.
- Azure App Service: Platform for hosting web applications and APIs.
- Azure Static Web Apps: Platform for hosting static web applications.
- Terraform: Infrastructure as Code tool.
- Git: Version control system.
- Azure DevOps/GitHub Actions: CI/CD platforms.


## Prerequisites

- Node.js and npm
- .NET SDK
- Terraform
- Azure account

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
   cd terraform
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

## Screenshots
1. Front-end

![Glucose Monitor UI](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/front-end.png)

2. Back-End

3. Cicd

![Cicd Build and Push Image to Azure Container Registry](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/cicd-build-and-push-image.PNG)

4. Terraform (local testing)

![Terraform Init](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/terraform-init-successful.png)
![Terraform Plan](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/terraform-plan-successful.png)

4. Terraform (during deployment to Azure)

![Terraform Apply](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/cicd-terraform-apply.PNG)

5. Azure Deployed Resources

Image Pushed in the Container Registry with the Backend Api
![Image Pushed in the Container Registry with the Backend Api](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/After-docker-push-image-in-Acr-Container-Registry.PNG)

How Resource Group looks like in Azure Console
![How Resource Group looks like in Azure Console](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/Creation-of-resources-in-resource-group.JPG)

Checking Error Logs on the App Service Api
![Checking Error Logs on the App Service Api](https://github.com/clarizalooktech/glucose-monitor-app-with-dotnet-azure/blob/main/assets/Checking-error-logs-app-service-api.jpg)

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