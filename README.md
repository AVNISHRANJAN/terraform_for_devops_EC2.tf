# Terraform and Ansible EC2 Repository

This repository keeps Terraform and Ansible-related infrastructure work in one place.

## Project structure

- `EC2_Instance_teraform/`: primary Terraform configuration for AWS EC2.
- `Ansible/`: Ansible workspace (currently includes infrastructure files under `Ansible/Terraform/`).

## Security

Private keys and Terraform state files are ignored by the root `.gitignore` and are not pushed to GitHub.

## Terraform quick start

```bash
cd EC2_Instance_teraform
terraform init
terraform apply
```
