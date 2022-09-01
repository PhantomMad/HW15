variable "image_id" {
  description = "Set image id from cloud"
  type        = string
  default     = "fd82re2tpfl4chaupeuf"
}
variable "subnet_id" {
  description = "Set existing subnet if it exists"
  type        = string
  default     = "e9bn2dnpuki39ctf26ml"
}
variable "size_hd" {
  description = "Set disk drive size in GB"
  type        = number
  default     = 15
}
variable "maven_gz" {
  description = "Maven arch version to delpoy"
  type        = string
  default     = "apache-maven-3.8.6-bin.tar.gz"
}
variable "git_url" {
  description = "Get url to build on maven engine"
  type        = string
  default     = "https://github.com/boxfuse/boxfuse-sample-java-war-hello.git"
}