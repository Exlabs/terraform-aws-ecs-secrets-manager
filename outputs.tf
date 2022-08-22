output "ecs_secrets" {
  value = local.ecs_secrets
  description = "Secrets description to be injected in the ECS Container definition."
}
