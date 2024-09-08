terraform {
  backend "s3" {
    bucket = "diogoscs-wpaas"
    key    = "terraformstate/repo-aws-vpc/tfstate"
    region = "us-east-1"
  }
}
