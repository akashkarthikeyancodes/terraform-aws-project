variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
  default     = "dev_cicd"
}

variable "ami_id" {
  description = "Amazon Linux AMI ID"
  type        = string
}
variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to access the EC2 instance over SSH"
  type        = string
}