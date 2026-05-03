# aurekai-terraform — provider skeleton
# Defines aurekai provider resources and check blocks.

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aurekai = {
      source  = "aurekai/aurekai"
      version = "~> 0.8.0-alpha"
    }
    null = { source = "hashicorp/null" }
    local = { source = "hashicorp/local" }
  }
}

variable "aurekai_version" {
  description = "Aurekai runtime version"
  default     = "0.8.0-alpha.5"
  type        = string
}

variable "model_tag" {
  description = "Default model tag for FPQ compression"
  default     = "qwen3-8b"
  type        = string
}

# ── Provider resources ────────────────────────────────────────────────────────

resource "aurekai_runtime" "main" {
  version = var.aurekai_version
}

resource "aurekai_model_memory" "default" {
  model_tag  = var.model_tag
  bits       = 8
  depends_on = [aurekai_runtime.main]
}

resource "aurekai_proof_store" "main" {
  store_path = ".aurekai/proofs"
  depends_on = [aurekai_runtime.main]
}

resource "aurekai_space" "client" {
  name       = "client-default"
  depends_on = [aurekai_runtime.main]
}

resource "aurekai_api_key" "workflow" {
  name       = "workflow-key"
  scopes     = ["runtime", "proof", "commerce"]
  depends_on = [aurekai_runtime.main]
}

# ── Check blocks — validate Akai runtime after provisioning ──────────────────

check "aurekai_doctor_deep" {
  assert {
    condition     = aurekai_runtime.main.status == "healthy"
    error_message = "Aurekai runtime is not healthy. Run: akai doctor --deep"
  }
}

check "aurekai_manifest_valid" {
  assert {
    condition     = aurekai_runtime.main.manifest_valid == true
    error_message = "Aurekai manifest is invalid. Run: akai verify --manifest artifact.json"
  }
}

check "aurekai_proof_store_ready" {
  assert {
    condition     = aurekai_proof_store.main.ready == true
    error_message = "Aurekai proof store is not ready."
  }
}

# ── Null resources for CI-time validation (no provider required) ─────────────

resource "null_resource" "doctor_check" {
  provisioner "local-exec" {
    command = "akai doctor --deep --json"
  }
  triggers = {
    version = var.aurekai_version
  }
}

resource "null_resource" "capability_check" {
  provisioner "local-exec" {
    command = "akai runtime capabilities --json"
  }
  depends_on = [null_resource.doctor_check]
}

resource "null_resource" "manifest_verify" {
  provisioner "local-exec" {
    command = "akai verify --manifest artifact.json --json"
  }
  depends_on = [null_resource.capability_check]
}

# ── Outputs ───────────────────────────────────────────────────────────────────

output "runtime_version" {
  value = var.aurekai_version
}

output "api_key_id" {
  value     = aurekai_api_key.workflow.id
  sensitive = true
}
