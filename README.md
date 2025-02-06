# Terraform Temporal Cloud Configuration

## Environment 🚀

[![Open in Dev Containers](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/nzuguem/terraform-temporal-cloud-configuration)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/nzuguem/terraform-temporal-cloud-configuration)

## Play Terraform Configuration

### Prerequisites

- [Temporary Cloud Account / Account ID][temporal-cloud]
- [Temporal Service Account for Terraform / Global Admin][temporal-tf-provider-setup]

```bash
terraform init

terraform apply
```

Seeing changes in Terraform Cloud 😎👌🔥

## Resources

- [Terraform Temporal Cloud Provider][temporal-tf-provider]

<!-- Links -->
[temporal-cloud]: https://cloud.temporal.io
[temporal-tf-provider-setup]: https://docs.temporal.io/production-deployment/cloud/terraform-provider#setup
[temporal-tf-provider]: https://registry.terraform.io/providers/temporalio/temporalcloud/0.6.0