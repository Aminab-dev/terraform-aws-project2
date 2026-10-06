module "network" {
  source = "../../modules/network"

  vpc_cidr       = var.vpc_cidr
  public_a_cidr  = var.public_a_cidr
  public_b_cidr  = var.public_b_cidr
  private_a_cidr = var.private_a_cidr
  private_b_cidr = var.private_b_cidr
  az_a           = var.az_a
  az_b           = var.az_b
}