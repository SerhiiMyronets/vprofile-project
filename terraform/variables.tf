variable "instance" {
  type = map(string)
  default = {
    type_free = "t2.micro"
    type_load = "t2.medium"
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
  default = "0.0.0.0/0" #"50.38.33.223/32"
}