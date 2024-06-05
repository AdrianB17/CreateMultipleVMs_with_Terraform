variable "subnet_names" {
  type    = list(string)
  default = [
    "default",
  ]
}


variable "image_names" {
  type    = list(string)
  default = ["template1"]
}