# Glucose Monitor App

This project is a Glucose Monitor App with a frontend built using React and a backend built using .NET. The application will be deployed using Terraform in Azure.

## Project Structure

- **Frontend**: The frontend is built using React and is located in the `src/ui` directory.
- **Backend**: The backend is built using .NET and is located in the `src/api` directory.
- **CI/CD**: GitHub Actions are used for continuous integration and continuous deployment, with workflows defined in the `.github/workflows` directory.

## Getting Started

### Prerequisites

- Node.js and npm
- .NET SDK
- Terraform
- Azure account

### Setting Up the Frontend

1. Navigate to the `src/ui` directory:
   ```sh
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

Glucose Monitor App Project Structure
Copy├── .github/
│   └── workflows/
│       └── deploy.yml               # CI/CD Pipeline (GitHub Actions)
│
├── src/
│   ├── api/                         # .NET Backend API
│   │   ├── Controllers/             # API Controllers (GlucoseController.cs)
│   │   ├── Models/                  # Data Models (GlucoseReading.cs)
│   │   ├── Data/                    # Database Context (GlucoseDbContext.cs)
│   │   ├── Services/                # Business Logic
│   │   ├── appsettings.json         # App configuration
│   │   ├── Program.cs               # Entry point
│   │   ├── GlucoseMonitor.csproj    # Project file
│   │   ├── Dockerfile               # API Dockerfile
│   │   └── README.md                # API documentation
│   │
│   ├── ui/                          # React Frontend
│   │   ├── src/                     # React source files
│   │   │   ├── components/          # Reusable React components
│   │   │   ├── pages/               # Page-level components (Home, Dashboard)
│   │   │   ├── services/            # API Calls (Axios, Fetch)
│   │   │   ├── App.js               # Main React component
│   │   │   ├── index.js             # Entry point
│   │   │   └── styles/              # CSS/Styled Components
│   │   ├── public/                  # Static assets
│   │   ├── package.json             # Dependencies & scripts
│   │   ├── .env                     # Environment variables
│   │   ├── Dockerfile               # Frontend Dockerfile
│   │   └── README.md                # Frontend documentation
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