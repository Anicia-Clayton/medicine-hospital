variable "aws_region"   { type = string  default = "us-east-1" }
variable "project_name" { type = string  default = "medicine-hospital-secure" }
variable "environment"  { type = string  default = "dev" }
variable "tags"         { type = map(string) default = { Owner = "you", Project = "MedSec" } }
