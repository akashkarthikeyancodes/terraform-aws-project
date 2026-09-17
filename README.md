# Terraform AWS Infrastructure Project

Infrastructure as Code project using Terraform to provision and manage AWS infrastructure.

This project demonstrates how Terraform can be used to create a complete AWS environment including networking, compute, storage, security, remote state management, and separate development and production configurations.
## Architecture

The infrastructure created by Terraform follows this architecture:

Internet
   |
Internet Gateway
   |
VPC (10.0.0.0/16)
   |
Public Subnet (10.0.1.0/24)
   |
EC2 Instance
   |
Security Group
   |-- SSH (22) - restricted to administrator IP
   |-- HTTP (80) - publicly accessible

S3 Bucket
   |
   |-- Versioning enabled
   |-- Server-side encryption enabled
   |-- Public access blocked

Terraform State
   |
S3 Remote Backend
   |
S3 Lock File
## AWS Services Used

- **Amazon VPC** — Provides the isolated network environment.
- **Public Subnet** — Hosts the EC2 instance.
- **Internet Gateway** — Provides internet connectivity to the public subnet.
- **Route Table** — Routes internet-bound traffic through the Internet Gateway.
- **Amazon EC2** — Runs the web server.
- **Security Group** — Controls inbound and outbound traffic.
- **Amazon S3** — Stores project data and Terraform remote state.
- **Terraform** — Provisions and manages the infrastructure as Code.

## Terraform Concepts Demonstrated

- Infrastructure as Code (IaC)
- Terraform providers
- Resources and dependencies
- Variables
- Outputs
- `.tfvars` environment configuration
- Terraform state management
- S3 remote backend
- S3 state locking using `use_lockfile`
- Terraform plan and apply workflow
- Infrastructure validation
- Environment separation using Dev and Prod configurations
- AWS security configuration

## Project Structure

```text
terraform-aws-infrastructure/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── .gitignore
├── README.md
│
├── environments/## Remote State Management

Terraform state is stored remotely in an Amazon S3 bucket instead of being maintained only on the local machine.

The remote backend provides:

- Centralized Terraform state storage
- S3 versioning for state recovery
- Server-side encryption
- Public access blocked
- State locking using Terraform's S3 lockfile mechanism

The backend is configured in `provider.tf`:

```hcl
terraform {
  backend "s3" {
    bucket       = "terraform-aws-project-akash-state"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
│   ├── dev.tfvars
│   └── prod.tfvars
│
└── bootstrap/
    └── main.tf
## Environment Configuration

The project supports separate development and production configurations using Terraform variable files.

### Development

```bash
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
## Security and Best Practices

This project includes several security-focused configurations:

- SSH access is restricted to a specific administrator IP address instead of allowing access from `0.0.0.0/0`.
- HTTP access on port 80 is publicly accessible for the web server.
- S3 public access is completely blocked.
- S3 server-side encryption using AES256 is enabled.
- S3 versioning is enabled for data and Terraform state recovery.
- Terraform state is stored remotely in a dedicated S3 bucket.
- Terraform state locking is enabled using the S3 lockfile mechanism.
- Terraform state files and generated `.terraform` files are excluded from Git using `.gitignore`.
- EC2 uses a specific AMI ID supplied through Terraform variables.
## Key Learning Outcomes

Through this project, I practiced:

- Designing AWS networking infrastructure with Terraform
- Creating reusable infrastructure using variables
- Managing Terraform state remotely
- Implementing state locking
- Managing multiple environments
- Applying AWS security best practices
- Understanding Terraform resource dependencies
- Using the Terraform plan/apply workflow
- Managing infrastructure changes through Git and GitHub
## Project Highlights

### Infrastructure as Code

The entire AWS infrastructure is defined using Terraform configuration files, allowing infrastructure to be created, modified, and destroyed consistently.

### Environment Management

Development and production configurations use separate `.tfvars` files while sharing the same Terraform infrastructure code.

### Remote State

Terraform state is stored in Amazon S3 with versioning, encryption, public-access blocking, and state locking enabled.

### Security

The EC2 security group restricts SSH access to an administrator IP while allowing HTTP traffic for the web server. S3 buckets are configured to block public access.

### Version Control

The Terraform project is managed using Git and hosted on GitHub, with Terraform-generated files and state files excluded from version control.
## Useful Commands

```bash
# Initialize Terraform
terraform init

# Format configuration
terraform fmt

# Validate configuration
terraform validate

# Review changes
terraform plan -var-file="environments/dev.tfvars"

# Apply infrastructure
terraform apply -var-file="environments/dev.tfvars"

# View outputs
terraform output

# Destroy development infrastructure
terraform destroy -var-file="environments/dev.tfvars"