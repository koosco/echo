# Echo Server - Spring Boot on Kubernetes

Simple Spring Boot REST API application deployed on k3d Kubernetes cluster.

## Project Overview

- **Framework**: Spring Boot 3.5.5
- **Language**: Java 21
- **Build Tool**: Gradle 8.14.3
- **Container**: Docker (Alpine-based)
- **Orchestration**: Kubernetes (k3d cluster)

## API Endpoints

| Endpoint | Method | Description | Response |
|----------|--------|-------------|----------|
| `/api` | GET | Echo endpoint | `Hello, World!` |

## Architecture

```
localhost:30000 (NodePort)
    ↓
k3d LoadBalancer (Port Mapping)
    ↓
Kubernetes Service (echo-service:8080)
    ↓
Deployment (3 Replicas)
    ↓
Pods (echo-server:v2 containers)
    ↓
Spring Boot Application (:8080)
```

## Prerequisites

- Java 21
- Docker
- k3d
- kubectl
- Gradle 8.14+

## Quick Start

### 1. Create k3d Cluster with Port Mapping

```bash
k3d cluster create mycluster -p "30000:30000@server:0"
```

**Important**: The port mapping `-p "30000:30000@server:0"` is required for NodePort access from localhost.

### 2. Build Application

```bash
# Using Gradle wrapper
./gradlew clean build

# Or using Makefile
make build
```

### 3. Build and Import Docker Image

```bash
# Build Docker image
docker build -t echo-server:v2 .

# Import to k3d cluster
k3d image import echo-server:v2 -c mycluster

# Or using Makefile (does both)
make build-image
```

### 4. Deploy to Kubernetes

```bash
# Apply deployment and service
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Or using Makefile
make apply deployment.yaml
make apply service.yaml
```

### 5. Access Application

```bash
# Root endpoint (404 - no mapping)
curl http://localhost:30000

# API endpoint (working)
curl http://localhost:30000/api
# Response: Hello, World!
```

## Makefile Commands

The project includes a Makefile for common operations:

```bash
# Build application
make build                    # Gradle clean build

# Docker operations
make build-image             # Build Docker image and import to k3d

# Kubernetes status
make pods                    # List all pods
make replicasets            # List all replica sets
make service                # List all services

# Deployment
make apply <file.yaml>      # Apply Kubernetes resource
make delete <file.yaml>     # Delete Kubernetes resource

# Cleanup
make delete-all             # Delete all Kubernetes resources
```

## Kubernetes Resources

### Deployment (deployment.yaml)

```yaml
Replicas: 3
Image: echo-server:v2
Container Port: 8080
Image Pull Policy: IfNotPresent
Restart Policy: Always
```

### Service (service.yaml)

```yaml
Type: NodePort
Port: 8080 (Service)
TargetPort: 8080 (Container)
NodePort: 30000 (External)
Selector: app=backend-app
```

## Common kubectl Commands

### Pod Management

```bash
# List pods
kubectl get pods
kubectl get pods -o wide

# View pod logs
kubectl logs <pod-name>
kubectl logs <pod-name> --tail=20
kubectl logs -f <pod-name>  # Follow logs

# Execute commands in pod
kubectl exec -it <pod-name> -- bash
kubectl exec -it <pod-name> -- sh  # Alpine uses sh

# Describe pod
kubectl describe pod <pod-name>

# Delete pod
kubectl delete pod <pod-name>
```

### Deployment Management

```bash
# List deployments
kubectl get deployments
kubectl get deploy -o wide

# Describe deployment
kubectl describe deployment echo-deployment

# Scale deployment
kubectl scale deployment echo-deployment --replicas=5

# Update deployment
kubectl apply -f deployment.yaml

# Rollout status
kubectl rollout status deployment/echo-deployment

# Rollout history
kubectl rollout history deployment/echo-deployment

# Delete deployment
kubectl delete -f deployment.yaml
kubectl delete deployment echo-deployment
```

### Service Management

```bash
# List services
kubectl get service
kubectl get svc -o wide

# Describe service
kubectl describe service echo-service

# Port forward (alternative access method)
kubectl port-forward svc/echo-service 8080:8080

# Delete service
kubectl delete -f service.yaml
kubectl delete service echo-service
```

### ReplicaSet Management

```bash
# List replica sets
kubectl get replicasets
kubectl get rs -o wide

# Describe replica set
kubectl describe rs <replicaset-name>
```

### Cluster Information

```bash
# Cluster info
kubectl cluster-info

# Node information
kubectl get nodes
kubectl describe node <node-name>

# All resources
kubectl get all
kubectl get all -o wide

# Resource usage
kubectl top nodes
kubectl top pods
```

### Troubleshooting

```bash
# Check events
kubectl get events
kubectl get events --sort-by=.metadata.creationTimestamp

# Debug pod issues
kubectl describe pod <pod-name>
kubectl logs <pod-name> --previous  # Previous container logs

# Check service endpoints
kubectl get endpoints echo-service

# Test DNS resolution
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup echo-service
```

## k3d Cluster Management

```bash
# Create cluster
k3d cluster create mycluster -p "30000:30000@server:0"

# List clusters
k3d cluster list

# Stop cluster
k3d cluster stop mycluster

# Start cluster
k3d cluster start mycluster

# Delete cluster
k3d cluster delete mycluster

# Import Docker image
k3d image import echo-server:v2 -c mycluster

# Check cluster port mapping
docker ps --filter "name=k3d-mycluster" --format "table {{.Names}}\t{{.Ports}}"
```

## Development Workflow

### Full Rebuild and Deploy

```bash
# 1. Build application
make build

# 2. Build and import Docker image
make build-image

# 3. Delete existing resources
make delete deployment.yaml
make delete service.yaml

# 4. Deploy new version
make apply deployment.yaml
make apply service.yaml

# 5. Wait for pods to be ready
kubectl wait --for=condition=ready pod -l app=backend-app --timeout=60s

# 6. Test
curl http://localhost:30000/api
```

### Quick Update (Code Changes Only)

```bash
# 1. Build and deploy
make build && make build-image

# 2. Restart deployment
kubectl rollout restart deployment echo-deployment

# 3. Check rollout status
kubectl rollout status deployment/echo-deployment
```

## Dockerfile

```dockerfile
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY build/libs/echo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## Project Structure

```
.
├── Dockerfile                 # Container image definition
├── Makefile                   # Build automation
├── README.md                  # This file
├── build.gradle              # Gradle build configuration
├── deployment.yaml           # Kubernetes deployment config
├── service.yaml              # Kubernetes service config
├── pod.yaml                  # Single pod config (not used in production)
└── src/
    └── main/
        └── java/
            └── com/io/echo/
                ├── EchoApplication.java     # Spring Boot main class
                └── EchoController.java      # REST API controller
```

## Troubleshooting

### Issue: Cannot access localhost:30000

**Cause**: k3d cluster not created with port mapping

**Solution**:
```bash
# Delete and recreate cluster with port mapping
k3d cluster delete mycluster
k3d cluster create mycluster -p "30000:30000@server:0"

# Rebuild and redeploy
make build-image
make apply deployment.yaml
make apply service.yaml
```

### Issue: Pods stuck in ImagePullBackOff

**Cause**: Image not imported to k3d cluster

**Solution**:
```bash
# Import image to cluster
k3d image import echo-server:v2 -c mycluster

# Restart deployment
kubectl rollout restart deployment echo-deployment
```

### Issue: Pods in CrashLoopBackOff

**Check logs**:
```bash
kubectl logs <pod-name>
kubectl describe pod <pod-name>
```

**Common causes**:
- Application build failure
- Port already in use inside container
- Missing dependencies or configuration

## Cleanup

```bash
# Delete all Kubernetes resources
make delete-all

# Or delete individually
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml

# Delete k3d cluster
k3d cluster delete mycluster
```

## License

This is a practice project for learning Kubernetes with Spring Boot.
