terraform {
  backend "s3" {
    bucket = "diogoscs-wpaas"
    key    = "terraformstate/repo-projeto-wpaas/wpaas-vpc-useast1-new/tfstate"
    region = "us-east-1"
  }
}
