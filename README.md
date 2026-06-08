# GitHub Actions Terraform Pipeline

A fully automated CI/CD pipeline on GCP that deploys a Python Calculator app using GitHub Actions, Terraform, and Docker.

## Pipeline Flow
- Push code to GitHub
- GitHub Actions triggers automatically
- Terraform provisions GCP infrastructure
- Docker image built and pushed to Artifact Registry
- App deployed to Cloud Run

## Technologies Used
- GitHub Actions
- Workload Identity Federation
- Terraform Modules
- Docker
- Artifact Registry
- Cloud Run

## Live App
https://calculator-app-ga-791907021272.us-central1.run.app
