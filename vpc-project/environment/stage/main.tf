provider "aws" {
  region = "us-west-2"
}
module "stage" {
  source = "../../module"
}
