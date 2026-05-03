# modules/proof-bundle-export/main.tf
# Aurekai proof-bundle-export provisioner module

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

resource "null_resource" "aurekai_proof_bundle_export" {
  triggers = {
    version = var.aurekai_version
  }

  provisioner "local-exec" {
    command = "akai proof bundle export --json || true"
  }
}

output "result" {
  value = "aurekai-proof-bundle-export provisioner applied at version ${var.aurekai_version}"
}
