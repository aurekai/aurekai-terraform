<p align="center">
  <img src="https://raw.githubusercontent.com/aurekai/aurekai/main/assets/aurekai-logo.svg" alt="Aurekai" width="520" />
</p>

# `aurekai-terraform` · v0.8.0-alpha.5

Official Terraform integration for Aurekai — `aurekai` provider resources, check blocks, postconditions, and null resource CI validators.

## Provider Resources

```hcl
resource "aurekai_runtime" "main" {
  version = "0.8.0-alpha.5"
}

resource "aurekai_model_memory" "default" {
  model_tag = "qwen3-8b"
  bits      = 8
}

resource "aurekai_proof_store" "main" {
  store_path = ".aurekai/proofs"
}

resource "aurekai_space" "client" {
  name = "client-default"
}

resource "aurekai_api_key" "workflow" {
  name   = "workflow-key"
  scopes = ["runtime", "proof", "commerce"]
}
```

## Check Blocks

```hcl
check "aurekai_doctor_deep" {
  assert {
    condition     = aurekai_runtime.main.status == "healthy"
    error_message = "Run: akai doctor --deep"
  }
}
```

## CI Validation (No Provider Required)

`null_resource` provisioners validate the Akai runtime via `local-exec`:

```hcl
resource "null_resource" "doctor_check" {
  provisioner "local-exec" { command = "akai doctor --deep --json" }
}
resource "null_resource" "capability_check" {
  provisioner "local-exec" { command = "akai runtime capabilities --json" }
}
resource "null_resource" "manifest_verify" {
  provisioner "local-exec" { command = "akai verify --manifest artifact.json --json" }
}
```

## Layout

```
provider.tf     Provider resources, check blocks, CI validators
main.tf         Root module, sub-module calls
modules/
  doctor-deep/          null_resource doctor check
  manifest-verify/      null_resource manifest validation
  release-gate/         null_resource release gate
  model-memory/         aurekai_model_memory resource
  proof-store/          aurekai_proof_store resource
examples/       Example configurations
```

## Quick Start

```bash
terraform init
terraform plan
terraform apply
```


Aurekai integration surface for Terraform.

Status: active
Type: infra

## Core Template Set

- doctor-deep
- manifest-verify
- model-memory-pack
- sae-audit
- semantic-cache-bench
- proof-bundle-export
- release-gate

## Canonical References

- Platform: https://github.com/aurekai/aurekai
- Native runtime: https://github.com/aurekai/native-runtime
- Integration registry: https://github.com/aurekai/aurekai/blob/main/registry/integrations.json
- Ecosystem map: https://github.com/aurekai/aurekai/blob/main/ECOSYSTEM_NAMES.md
## Starter Templates

- examples/release-gate/main.tf
