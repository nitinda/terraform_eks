data "http" "demo-workstation-external-ip" {
  url = "http://icanhazip.com"
}

data "aws_caller_identity" "demo-current" {}
