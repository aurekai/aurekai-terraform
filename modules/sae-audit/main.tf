# modules/sae-audit/main.tf
# Aurekai sae-audit provisioner module

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

resource "null_resource" "aurekai_sae_audit" {
  triggers = {
    version = var.aurekai_version
  }

  provisioner "local-exec" {
    command = "akai sae audit --json || true"
  }
}

output "result" {
  value = "aurekai-sae-audit provisioner applied at version ${var.aurekai_version}"
}
