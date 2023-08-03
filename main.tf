resource "aws_secretsmanager_secret" "this" {
  name        = var.name
  description = var.description
}

resource "random_id" "policy_suffix" {
  byte_length = 8
}

resource "aws_iam_policy" "this" {
  name        = "SecretsManagerPolicyForECSTaskExecutionRole-${random_id.policy_suffix.hex}"
  description = "Access rights to SecretsManager Secret created by terraform-aws-ecs-secrets-manager module"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          aws_secretsmanager_secret.this.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.ecs_task_execution_roles)
  role       = each.value
  policy_arn = aws_iam_policy.this.arn
}

locals {
  ecs_secrets = [
    for key_name in var.key_names :{
      name = key_name
      valueFrom = "${aws_secretsmanager_secret.this.arn}:${key_name}::"
    }
  ]
}
