# Infrastructure Design - Sync Service

## Overview

The goal of this infrastructure setup is to provide:

- Auto-scaling capability
- Secure application deployment
- Low operational overhead
- Startup-friendly cost optimization
- High availability

---

# Compute Choice

## Selected Platform: Google Kubernetes Engine (GKE)

### Why GKE Was Selected

For this project, GKE is the preferred option because:

- Better scalability
- Easy container orchestration
- Built-in rolling updates
- Self-healing workloads
- Easier future microservices expansion

Although Cloud Run is cheaper for very small workloads,
GKE provides better long-term flexibility and operational control.

Compute Engine VMs require more manual management such as:

- Scaling configuration
- Load balancing setup
- Patching
- Container orchestration

Because the service may grow in future, GKE gives a better balance between scalability and maintainability.

---

# Auto Scaling Approach

Horizontal Pod Autoscaler (HPA) is configured in GKE.

Scaling metrics include:

- CPU usage
- Memory usage
- Request throughput

Benefits:

- Cost optimization during low traffic
- Automatic scaling during traffic spikes
- Better resource utilization

---

# MongoDB Hosting Approach

MongoDB Atlas is recommended instead of self-managed MongoDB.

### Reasons

- Managed backups
- Automated patching
- High availability
- Easy scaling
- Reduced operational overhead

For startup environments, MongoDB Atlas reduces maintenance effort and improves reliability.

---

# Networking Design

## VPC

A dedicated custom VPC is created for the infrastructure.

Subnets:
- Public subnet
- Private subnet

### Public Components

- Load Balancer
- Ingress Controller

### Private Components

- GKE worker nodes
- Internal services

---

# Ingress & Traffic Flow

Traffic Flow:

Internet → HTTPS Load Balancer → Ingress → GKE Service → Application Pods

TLS termination is handled at the Load Balancer.

Benefits:

- Secure HTTPS access
- Centralized traffic management
- Easier SSL certificate management

---

# Secrets & IAM

## Secret Management

Secrets are stored using:

- GCP Secret Manager

Secrets include:

- MongoDB credentials
- API keys
- JWT secrets

No secrets are stored inside GitHub repositories.

---

## IAM Design

Separate service accounts are created for:

- Jenkins CI/CD
- Application workloads
- Monitoring tools

Least privilege access model is followed.

Benefits:

- Improved security
- Reduced blast radius
- Better audit visibility

---

# Logging & Monitoring

## Logging Stack

Recommended stack:

- Google Cloud Logging
- Loki
- Grafana

Logs collected:
- Application logs
- Container logs
- Kubernetes events

---

## Monitoring Stack

Recommended tools:

- Prometheus
- Grafana
- GCP Monitoring

Metrics monitored:

- CPU and memory
- Pod health
- API latency
- MongoDB connectivity
- Error rates

---

# Cost Optimization

To support startup constraints:

- Small GKE node pool initially
- Auto-scaling enabled
- Spot/preemptible nodes for non-critical workloads
- Managed MongoDB instead of self-hosted cluster
- Resource limits configured

This setup balances scalability, security, and operational cost.
