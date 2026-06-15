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

---

## Repository Structure

```
github-actions-terraform/
├── .github/
│   └── workflows/
│       ├── deploy-dev.yml
│       ├── deploy-stage.yml
│       └── deploy-prod.yml
├── environments/
│   ├── dev/
│   ├── stage/
│   └── prod/
├── modules/
│   ├── artifact_registry/
│   ├── cloud_run/
│   └── monitoring/
├── app.py
├── Dockerfile
└── requirements.txt
```

---

## Environment Setup

| Environment | Branch | Cloud Run Service | Artifact Registry | Deletion Protection |
|-------------|--------|-------------------|-------------------|---------------------|
| Dev | `dev` | `calculator-app-dev` | `calculator-repo-dev` | Disabled |
| Stage | `stage` | `calculator-app-stage` | `calculator-repo-stage` | Disabled |
| Prod | `main` | `calculator-app-prod` | `calculator-repo-prod` | Enabled |

---

## GitHub Actions Setup

### Branch → Environment Mapping

| Branch | Workflow File | Environment |
|--------|--------------|-------------|
| `dev` | `deploy-dev.yml` | Dev |
| `stage` | `deploy-stage.yml` | Stage |
| `main` | `deploy-prod.yml` | Prod |

### Required GitHub Secrets

| Secret Name | Description |
|-------------|-------------|
| `GCP_PROJECT_ID` | Your GCP Project ID |
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | Workload Identity Provider resource name from GCP |
| `GCP_SERVICE_ACCOUNT` | terraform-deployer service account email |

---

## Monitoring and Alerting

Each environment provisions the following via the `modules/monitoring` module:

| Resource | Name Pattern |
|----------|-------------|
| Uptime Check | `Uptime Check - calculator-app-<env>` |
| Alert Policy | `Uptime Alert - calculator-app-<env>` |
| Notification Channel | `Email Alerts - <env>` |

The alert email is pulled from Secret Manager (`alert-email`) at deploy time. If the uptime check fails for 60 seconds, an email alert fires automatically.

**Verify in GCP Console:** Monitoring → Uptime checks / Alerting

---

## Deployment Process

```bash
# Deploy to Dev
git checkout main
git add .
git commit -m "your change"
git checkout dev
git merge main
git push origin dev

# Deploy to Stage
git checkout stage
git merge dev
git push origin stage

# Deploy to Prod
git checkout main
git merge stage
git push origin main
```

Each push triggers the corresponding GitHub Actions workflow automatically.
