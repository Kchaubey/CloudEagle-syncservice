# CI/CD Design Document - Sync Service

## Overview

The `sync-service` is a Spring Boot application connected to MongoDB and deployed on GCP virtual machines.

This CI/CD design focuses on:

- Automated deployments
- Secure configuration management
- Zero/minimal downtime
- Rollback capability
- Multi-environment deployments

---

# Branching Strategy

| Branch | Environment |
|---|---|
| develop | QA |
| staging | Staging |
| main | Production |

Feature branches are merged into develop using Pull Requests.

Production deployment requires:
- Manual approval
- Protected branch rules
- PR reviews

---

# Jenkins Pipeline Stages

1. Checkout
2. Build
3. Unit Test
4. SonarQube Scan
5. Docker Build
6. Push Docker Image
7. Deploy

---

# PR vs Merge

## Pull Request

- Build validation
- Unit testing
- SonarQube analysis
- No deployment

## Merge

- Build application
- Create Docker image
- Push image
- Deploy automatically

---

# Rollback Strategy

Rollback uses previous Docker image versions.

If health check fails:
- Redeploy previous image
- Restore traffic

---

# Configuration Management

Separate Spring profiles:
- application-qa.yml
- application-staging.yml
- application-prod.yml

---

# Secrets Management

Secrets are stored in:
- Jenkins Credentials Manager
- GCP Secret Manager

Secrets include:
- MongoDB credentials
- API keys
- JWT secrets

---

# Deployment Strategy

Blue/Green deployment strategy is used because it provides:

- Near zero downtime
- Fast rollback
- Safer deployments

---

# Monitoring

Recommended stack:

- Prometheus
- Grafana
- Loki
- ELK
