terraform {
  required_version = ">= 1.6.0"
}

variable "aurekai_version" {
  type    = string
  default = "0.8.0-alpha.4"
}

resource "null_resource" "doctor_deep" {
  provisioner "local-exec" {
    command = "akai doctor --deep"
  }
}

resource "null_resource" "manifest_verify" {
  provisioner "local-exec" {
    command = "test -f aurekai.manifest.json && test -f bonfyre.manifest.json"
  }
}
