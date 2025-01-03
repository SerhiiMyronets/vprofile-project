variable "instance" {
  type = map(string)
  default = {
    type = "t2.micro"
    ami  = "ami-005fc0f236362e99f" # ubuntu 22.04
  }
}

variable "keypair" {
  type = map(string)
  default = {
    name      = "vprofile-ci-key"
    algorithm = "ED25519"
  }
}

variable "my_ip_cidr" {
  type = string
  default = "50.38.33.223/32"
}