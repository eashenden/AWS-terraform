variable "AWS_access_key_id" {
  type      = string
  sensitive = true
}
variable "AWS_access_key_secret" {
  type      = string
  sensitive = true
}
variable "region" {
  default = "us-west-1"
}
variable "az-b" {
  default = "b"
}
variable "az-c" {
  default = "c"
}
