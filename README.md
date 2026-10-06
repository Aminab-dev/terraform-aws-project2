# AWS Networking with Terraform

A reusable Terraform network module deployed across two Availability
Zones in AWS Frankfurt (eu-central-1).

## Architecture

- VPC: 10.0.0.0/16, with DNS support and hostnames enabled.
- Public subnets: 10.0.1.0/24 and 10.0.2.0/24.
- Private subnets: 10.0.11.0/24 and 10.0.12.0/24.
- One Internet Gateway.
- One NAT Gateway and Elastic IP per Availability Zone.
- Public default route through the Internet Gateway.
- Each private default route through its same-AZ NAT Gateway.

## Project structure

- bootstrap/: creates the S3 state bucket and its protection settings.
- environments/dev/: development configuration and module invocation.
- modules/network/: reusable network resources, inputs, and outputs.

## Prerequisites

- Terraform >= 1.10 and < 2.0.
- AWS CLI and valid AWS credentials with appropriate permissions.
- Access to the S3 backend when using an existing deployment.

Credentials must remain outside the repository.

## Bootstrap the state bucket

Run from the repository root:

```bash
terraform -chdir=bootstrap init
terraform -chdir=bootstrap plan -out=bootstrap.tfplan
terraform -chdir=bootstrap apply bootstrap.tfplan
terraform -chdir=bootstrap output -raw state_bucket_name
```

Before applying, review the plan.

For a new deployment, set the resulting bucket name in
environments/dev/backend.tf. The bucket must exist before initializing
the network configuration.

The bootstrap configuration uses its own local state. Keep that state
securely backed up and excluded from Git.

## Deploy the network

Copy environments/dev/terraform.tfvars.example to
environments/dev/terraform.tfvars and adjust the values as needed.

```bash
terraform -chdir=environments/dev init
terraform fmt -check -recursive
terraform -chdir=environments/dev validate
terraform -chdir=environments/dev plan -out=network.tfplan
terraform -chdir=environments/dev apply network.tfplan
terraform -chdir=environments/dev output
```

Review the saved plan before applying. Changing subnet CIDRs or
Availability Zones can require resource replacement.

## State and refactoring

Network state is stored in S3 at network/terraform.tfstate.

The bucket has versioning, server-side encryption, and public access
blocking. The S3 backend uses lockfiles to coordinate state writes.

Existing resources were moved into module.network using moved blocks,
preserving their AWS resource IDs.

When migrating an existing local network state to S3, use
terraform init -migrate-state from the network configuration directory
and review the migration prompt.

## Verification

Check in AWS that:

- Four subnets belong to the correct VPC and Availability Zones.
- Public subnets use the route table pointing to the Internet Gateway.
- Private subnets route through their respective same-AZ NAT Gateways.
- Routes are active and NAT Gateways are Available.
- NAT Gateways have the expected Elastic IPs.
- The network state object exists in S3.

A subsequent terraform plan should report no changes.

## Evidence

Store screenshots in an evidence/ directory:

- VPC resource map.
- Public and private route details.
- NAT Gateway status and Elastic IPs.
- Successful validation, apply summary, and Terraform outputs.

## Cleanup

NAT Gateways and public IPv4 addresses incur charges while provisioned.

To remove the network:

```bash
terraform -chdir=environments/dev plan -destroy -out=destroy.tfplan
terraform -chdir=environments/dev apply destroy.tfplan
```

Review the destruction plan first. Check for dependent workloads before
removing the network, and verify cleanup in AWS afterward.

Do not destroy the bootstrap bucket while the network still uses it.
The versioned bucket retains state history after network cleanup.

## Recovery

Keep the configuration and lock files in Git. S3 versioning preserves
previous network state versions.

Before recovering state, stop concurrent Terraform operations and
securely back up the current state. Investigate the relevant versions;
restoring old state alone does not restore or roll back AWS resources.

Never commit credentials, state files, or saved plans.