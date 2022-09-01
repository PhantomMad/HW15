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
variable "tomcat_gz" {
  description = "Tomcat arch version to deploy"
  type        = string
  default     = "apache-tomcat-9.0.65.tar.gz"
}