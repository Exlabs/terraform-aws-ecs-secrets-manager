variable "name" {
  description = "AWS SecretsManager secret name"
  type        = string
  nullable    = false
}

variable "description" {
  description = "AWS SecretsManager secret description"
  type        = string
  default     = null
}

variable "ecs_task_execution_roles" {
  description = "ECS task execution role names that should be allowed to read secrets"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_names" {
  description = "Secret names that will be injected as env variables"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "enable_secret_assigned_to_single_key" {
  description = "Enables returning the whole secret as a single key-value pair"
  type        = bool
  nullable    = false
  default     = false
}
