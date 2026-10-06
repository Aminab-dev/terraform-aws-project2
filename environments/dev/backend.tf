terraform {
  backend "s3" {
    bucket       = "amina-terraform-state-ca5d23c9727df4fdd756d4fa3b"
    key          = "network/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}