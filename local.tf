locals {
  product = "gsc-intergy-sandbox"

  # Product
  vpc_id        = "vpc-061774dfe5660afc9"
  bucket        = "mymediaiso"
  ib_subnet     = "subnet-0e0c2f68a2dad2762"
  lambda_subnet = "subnet-09fa30cccbd06d131"
  cidr          = "0.0.0.0/0"

  default_tags = {
    "map-migrated" = "migKEADT9B6KO"
    "MPE ID"       = "KEADT9B6KO"
    "Environment"  = terraform.workspace
    "Owner"        = local.product
    "launchedby"   = "terraform"
  }
}
