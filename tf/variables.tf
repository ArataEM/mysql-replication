variable "profile" {
  type = string
  default = "devops"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-central-1a","eu-central-1b"]
}

variable "image_id" {
  type = string
  default = "ami-0c9354388bb36c088"
}

variable "replicas" {
  type = number
  default = 2
}

variable "public_key" {
  type = string
  default = "~/.ssh/id_ed25519.pub"
}
