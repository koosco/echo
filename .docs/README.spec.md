# README.md Specification

This document defines the structure, style, and content guidelines for the project's README.md file.

## Document Purpose

Comprehensive guide for Spring Boot application deployment on k3d Kubernetes cluster, covering setup, deployment, and operational commands.

## Target Audience

- Developers new to Kubernetes
- DevOps engineers deploying Spring Boot applications
- Team members onboarding to the project

## Document Structure

### 1. Header Section
```markdown
# [Project Name] - [Technology Stack]

[One-line description]
```

**Requirements**:
- Clear project name
- Primary technology stack in title
- Concise description (1-2 sentences)

### 2. Project Overview

**Section**: `## Project Overview`

**Content**:
- Framework and version
- Programming language and version
- Build tool and version
- Container technology
- Orchestration platform

**Format**: Bullet list with bold labels

### 3. API Endpoints

**Section**: `## API Endpoints`

**Content**:
- Markdown table with columns: Endpoint, Method, Description, Response
- One row per endpoint
- Include HTTP method
- Clear response example

**Update Trigger**: When API endpoints are added/modified/removed

### 4. Architecture Diagram

**Section**: `## Architecture`

**Content**:
- ASCII diagram showing request flow
- Top-to-bottom flow using arrows (↓)
- Include all layers: External port → LoadBalancer → Service → Deployment → Pods → Application

**Format**:
```
[External Interface]
    ↓
[Load Balancer]
    ↓
[Service Layer]
    ↓
[Orchestration Layer]
    ↓
[Container Layer]
    ↓
[Application Layer]
```

### 5. Prerequisites

**Section**: `## Prerequisites`

**Content**:
- Bullet list of required software
- Include version requirements if applicable
- Order: Language → Build Tool → Container → Orchestration → CLI tools

### 6. Quick Start

**Section**: `## Quick Start`

**Requirements**:
- Numbered subsections (###)
- Step-by-step instructions
- Code blocks with bash syntax highlighting
- Comments for important flags or options
- Include both manual commands and Makefile alternatives

**Standard Steps**:
1. Cluster setup
2. Application build
3. Container image build and import
4. Kubernetes deployment
5. Access/testing

### 7. Makefile Commands

**Section**: `## Makefile Commands`

**Content**:
- Grouped by category
- Each command with inline comment explaining purpose
- Code block with bash syntax

**Categories**:
- Build operations
- Container operations
- Kubernetes status commands
- Deployment commands
- Cleanup commands

### 8. Kubernetes Resources

**Section**: `## Kubernetes Resources`

**Subsections**: One per resource type (Deployment, Service, etc.)

**Content Format**:
```markdown
### [Resource Type] ([filename])

```yaml
Key: Value
Key: Value
```
```

**Include**: Critical configuration values only (replicas, ports, image, policies)

### 9. Common kubectl Commands

**Section**: `## Common kubectl Commands`

**Subsections**:
- Pod Management
- Deployment Management
- Service Management
- ReplicaSet Management
- Cluster Information
- Troubleshooting

**Format**:
- Code blocks with bash syntax
- Group related commands
- Include both short and long flags
- Add inline comments for complex commands

**Update Trigger**: When new resource types are added or common operations change

### 10. k3d Cluster Management

**Section**: `## k3d Cluster Management`

**Content**:
- Cluster lifecycle commands (create, delete, start, stop)
- Image management
- Port mapping verification
- Code block with bash syntax

**Critical**: Always include port mapping in cluster creation commands

### 11. Development Workflow

**Section**: `## Development Workflow`

**Subsections**:
- Full Rebuild and Deploy
- Quick Update (Code Changes Only)

**Format**:
- Numbered steps with explanatory comments
- Complete command sequences
- Include verification steps

### 12. Dockerfile

**Section**: `## Dockerfile`

**Content**:
- Complete Dockerfile in code block
- dockerfile syntax highlighting

**Update Trigger**: When Dockerfile is modified

### 13. Project Structure

**Section**: `## Project Structure`

**Content**:
- ASCII tree structure
- File/directory names with inline comments
- Include only relevant files (exclude .git, .gradle, build artifacts)

**Update Trigger**: When project structure changes significantly

### 14. Troubleshooting

**Section**: `## Troubleshooting`

**Format per Issue**:
```markdown
### Issue: [Clear problem description]

**Cause**: [Root cause explanation]

**Solution**:
```bash
[Step-by-step commands]
```
```

**Content Requirements**:
- Common issues encountered
- Clear cause identification
- Actionable solutions
- Include verification commands

**Update Trigger**: When new issues are discovered or resolved

### 15. Cleanup

**Section**: `## Cleanup`

**Content**:
- Commands to remove all resources
- Both individual and batch cleanup options
- Code block with bash syntax

### 16. License/Footer

**Section**: `## License` or project notes

**Content**: License type or project purpose statement

## Style Guidelines

### Code Blocks

**Bash Commands**:
```markdown
```bash
# Comment explaining complex commands
command --flag value
```
```

**YAML Configuration**:
```markdown
```yaml
key: value
nested:
  key: value
```
```

**Dockerfile**:
```markdown
```dockerfile
FROM image:tag
```
```

### Command Documentation

**Format**: `command arg # inline comment`

**Include**:
- Flag explanations for non-obvious options
- Expected output for verification commands
- Alternative approaches when applicable

### Tables

**Format**: Use GitHub Flavored Markdown tables
```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Value    | Value    | Value    |
```

**Alignment**: Left-align text, right-align numbers

### Emphasis

- **Bold**: For labels, important terms, file names
- `Code`: For commands, file paths, variables, ports
- *Italic*: Minimal use, for subtle emphasis only

### Links

- Use relative links for internal project files
- Use absolute URLs for external documentation
- Prefer official documentation links

## Update Guidelines

### When to Update README

**Immediate**:
- API endpoint changes
- Architecture changes
- New dependencies or prerequisites
- Critical troubleshooting steps

**Regular**:
- Version bumps in Project Overview
- New kubectl commands in common use
- Dockerfile modifications

**As Needed**:
- Minor wording improvements
- Additional examples
- Expanded troubleshooting

### Version Information Updates

**Location**: Project Overview section

**Update Trigger**:
- Framework version upgrade
- Language version change
- Build tool version change
- Major dependency updates

**Format**: Keep version numbers synchronized with actual `build.gradle` or `pom.xml`

### Port and Configuration Updates

**Locations to Update**:
- Architecture diagram
- Quick Start commands
- k3d cluster creation
- Access/testing examples
- Kubernetes Resources section

**Consistency Check**: Verify all port references match across sections

### Command Updates

**When Adding Commands**:
1. Add to appropriate category in Common kubectl Commands
2. Include in relevant workflow if applicable
3. Add to Troubleshooting if it solves a known issue

**When Removing Commands**:
1. Remove from all sections
2. Update workflows that referenced it
3. Archive in separate documentation if historically important

## Maintenance Checklist

Before committing README updates:

- [ ] All version numbers match current configuration files
- [ ] All port numbers are consistent across sections
- [ ] Code blocks have proper syntax highlighting
- [ ] All commands have been tested
- [ ] Internal file references are accurate
- [ ] External links are not broken
- [ ] Troubleshooting section reflects current issues
- [ ] Project structure matches actual directory layout
- [ ] Architecture diagram reflects current setup

## Automated Updates

### Scripts to Consider

1. **Version Extractor**: Parse `build.gradle` for version info
2. **Port Validator**: Check port consistency across README
3. **Command Tester**: Validate all bash commands execute without errors
4. **Link Checker**: Verify external URLs are accessible

### Integration Points

- Pre-commit hook: Validate README consistency
- CI/CD: Run command validation on README examples
- Documentation generation: Auto-update API endpoints from code

## Template Variables

When creating README for similar projects, replace:

- `[PROJECT_NAME]`: Echo Server
- `[FRAMEWORK]`: Spring Boot
- `[FRAMEWORK_VERSION]`: 3.5.5
- `[LANGUAGE]`: Java
- `[LANGUAGE_VERSION]`: 21
- `[BUILD_TOOL]`: Gradle
- `[BUILD_TOOL_VERSION]`: 8.14.3
- `[CLUSTER_NAME]`: mycluster
- `[IMAGE_NAME]`: echo-server
- `[IMAGE_TAG]`: v2
- `[SERVICE_NAME]`: echo-service
- `[DEPLOYMENT_NAME]`: echo-deployment
- `[EXTERNAL_PORT]`: 30000
- `[SERVICE_PORT]`: 8080
- `[CONTAINER_PORT]`: 8080

## File Metadata

- **Spec Version**: 1.0
- **Last Updated**: 2025-11-21
- **README Version**: 1.0
- **Maintained By**: Development Team
- **Review Frequency**: Quarterly or on major changes
