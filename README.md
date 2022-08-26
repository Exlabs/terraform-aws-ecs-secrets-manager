# terraform-aws-ecs-secrets-manager

Terraform module to create a SecretManager secret and generate secrets definition to be injected in the ECS Container definition.

This module uses the recommended way of passing sensitive data from SecretManager to ECS Task without hardcoding any sensitive values in the ECS Container definition.

## Usage

```hcl
module "secrets" {
  source  = "exlabs/ecs-secrets-manager/aws"

  name = "data-pipeline-secrets"
  ecs_task_execution_role = "ecs-task-execution-role"

  key_names = [
    "STRIPE_PUBLIC_KEY",
    "STRIPE_SECRET_KEY",
    "STRIPE_WEBHOOK_SECRET"
  ]
}

resource "aws_ecs_task_definition" "data_pipeline" {
  #...

  container_definitions = <<TASK_DEFINITION
  [
    {
      "secrets": ${jsonencode(module.secrets.ecs_secrets)},
      #...
    }
  ]
  TASK_DEFINITION
}
```

After `terraform apply` you have to go to the AWS Console SecretsManager dashboard, select created secret and set values by creating a key-value pair for each defined key name.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.secrets_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.secret_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_secretsmanager_secret.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_iam_policy_document.secrets_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name                                                                                                          | Description | Type | Default | Required |
|---------------------------------------------------------------------------------------------------------------|-------------|------|---------|:--------:|
| <a name="input_ecs_task_execution_role"></a> [ecs\_task\_execution\_role](#input\_ecs\_task\_execution\_role) | ECS task execution role name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name)                                                                | AWS SecretsManager secret name | `string` | n/a | yes |
| <a name="input_key_names"></a> [key\_names](#input\_key\_names)                                               | Secret names that will be injected as env variables | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_secrets"></a> [ecs\_secrets](#output\_ecs\_secrets) | Secrets description to be injected in the ECS Container definition. |
<!-- END_TF_DOCS -->
