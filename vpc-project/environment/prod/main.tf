provider "aws" {
  region = "ap-south-1"
}
module "stage" {
  source = "../../module"
}
