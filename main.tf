# aurekai-terraform — root module
# Calls all Aurekai provisioner sub-modules

terraform {
  required_version = ">= 1.6.0"
}

variable "aurekai_version" {
  default = "0.8.0-alpha.4"
}

module "doctor_deep" {
  source          = "./modules/doctor-deep"
  aurekai_version = var.aurekai_version
}

module "manifest_verify" {
  source          = "./modules/manifest-verify"
  aurekai_version = var.aurekai_version
}

module "release_gate" {
  source          = "./modules/release-gate"
  aurekai_version = var.aurekai_version
}
