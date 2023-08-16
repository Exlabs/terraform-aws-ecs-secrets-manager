output "ecs_secrets" {
  value = local.ecs_secrets
  description = "Secrets description to be injected in the ECS Container definition."
}

output "secretsmanager_secret_arn" {
  value = aws_secretsmanager_secret.this.arn
  description = "AWS SecretsManager secret ARN"
}
