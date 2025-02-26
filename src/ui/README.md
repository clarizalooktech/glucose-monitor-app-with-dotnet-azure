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