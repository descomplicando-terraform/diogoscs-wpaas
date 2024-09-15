terraform {
  backend "s3" {
    bucket = "diogoscs-wpaas"
    key    = "terraformstate/repo-projeto-wpaas/wpaas-prd/tfstate"
    region = "us-east-1"
  }
}
