/*variable "my_eks" {
  type = object({
    name     = string,
    role_arn = string,
    version  = string,
  })
}*/
variable "me_name" {
  type = string
  default = "my-eks"
}
variable "me_version" {
  type = string
  default = "1.25"
}
variable "sub_eks" {
  type = list
}
variable "kube_name" {
  type = string
  default = "kube-proxy-addon"
}
variable "kube_version" {
  type = string
  default = "v1.25.6-eksbuild.1"
}
variable "core_name" {
  type = string
  default = "core-DNS-addon"
}
variable "core_version" {
  type = string
  default = "v1.9.3-eksbuild.2"
}
variable "cni_name" {
  type = string
  default = "vpc-cni-addon"
}
variable "cni_version" {
  type = string
  default = "v1.12.2-eksbuild.1"
}