variable "name" {
  description = "AWS SecretsManager secret name"
  type = string
}

variable "ecs_task_execution_role" {
  description = "ECS task execution role name"
  type = string
}

variable "key_names" {
  description = "Secret names that will be injected as env variables"
  type = list(string)
}
