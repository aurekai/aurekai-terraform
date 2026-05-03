# modules/semantic-cache-bench/main.tf
# Aurekai semantic-cache-bench provisioner module

terraform {
  required_version = ">= 1.6.0"
}

variable "aurekai_version" {
  default = "0.8.0-alpha.4"
}

variable "manifest_path" {
  default = "artifact.json"
}

variable "tag" {
  default = "latest"
}

variable "model_id" {
  default = "default"
}

variable "queries" {
  default = 100
}

variable "version" {
  default = "0.8.0-alpha.4"
}

resource "null_resource" "aurekai_semantic_cache_bench" {
  triggers = {
    version = var.aurekai_version
  }

  provisioner "local-exec" {
    command = "akai semantic cache bench --json || true"
  }
}

output "result" {
  value = "aurekai-semantic-cache-bench provisioner applied at version ${var.aurekai_version}"
}
