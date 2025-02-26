├── .github/
│   └── workflows/
│       └── deploy.yml               # CI/CD Pipeline (GitHub Actions)
│
├── src/
│   ├── api/                         # .NET Backend API
│   │   ├── Controllers/              # API Controllers (GlucoseController.cs)
│   │   ├── Models/                   # Data Models (GlucoseReading.cs)
│   │   ├── Data/                     # Database Context (GlucoseDbContext.cs)
│   │   ├── Services/                 # Business Logic
│   │   ├── appsettings.json          # App configuration
│   │   ├── Program.cs                # Entry point
│   │   ├── GlucoseMonitor.csproj     # Project file
│   │   ├── Dockerfile                # API Dockerfile
│   │   └── README.md                 # API documentation
│   │
│   ├── ui/                           # React Frontend
│   │   ├── src/                      # React source files
│   │   │   ├── components/           # Reusable React components
│   │   │   ├── pages/                # Page-level components (Home, Dashboard)
│   │   │   ├── services/             # API Calls (Axios, Fetch)
│   │   │   ├── App.js                # Main React component
│   │   │   ├── index.js              # Entry point
│   │   │   ├── styles/               # CSS/Styled Components
│   │   ├── public/                   # Static assets
│   │   ├── package.json              # Dependencies & scripts
│   │   ├── .env                      # Environment variables
│   │   ├── Dockerfile                # Frontend Dockerfile
│   │   └── README.md                 # Frontend documentation
│
├── infra/
│   ├── terraform/
│   │   ├── main.tf                   # Main Terraform file
│   │   ├── variables.tf               # Input variables
│   │   ├── outputs.tf                 # Output values
│   │   ├── providers.tf               # Azure provider setup
│   │   ├── app-service.tf             # Defines Azure App Service
│   │   ├── sql-database.tf            # Defines Azure SQL (Serverless)
│   │   ├── acr.tf                     # Azure Container Registry (for Docker images)
│   │   ├── static-web-app.tf          # Azure Static Web Apps for React
│   │   ├── networking.tf              # (Optional) Networking & security setup
│   │   ├── terraform.tfvars           # Variable values (excluded from Git)
│   │   ├── backend.tf                 # (If using remote Terraform state)
│   └── README.md                      # Infra documentation
│
├── test/                             # Unit and Integration Tests
│   ├── api-tests/                    # API Tests
│   ├── frontend-tests/               # React Frontend Tests (Jest, Cypress)
│   ├── load-tests/                   # Performance Tests
│   ├── README.md                      # Test documentation
│
├── Dockerfile                        # Root Dockerfile (if using multi-container setup)
├── docker-compose.yml                 # Compose file (if running multiple services)
├── README.md                         # Documentation
└── .gitignore                         # Git Ignore file