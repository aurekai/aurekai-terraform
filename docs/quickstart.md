# Quickstart — aurekai-terraform

Terraform modules for provisioning Aurekai pipeline runners.

## Requirements

- Terraform >= 1.6.0
- `akai` CLI on `PATH`

## Initialize

```bash
terraform init
terraform plan
terraform apply
```

## Modules

| Module | Description |
|---|---|
| `modules/doctor-deep` | Provisioner for `akai doctor --deep` |
| `modules/manifest-verify` | Manifest verification |
| `modules/model-memory-pack` | Model artifact packing |
| `modules/sae-audit` | SAE audit runner |
| `modules/semantic-cache-bench` | Cache benchmark |
| `modules/proof-bundle-export` | Proof bundle export |
| `modules/release-gate` | Release gate check |

## Validate

```bash
bash tests/validate-schemas.sh
bash tests/validate-scripts.sh
```
