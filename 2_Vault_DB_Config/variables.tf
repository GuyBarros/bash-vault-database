variable "application_name" {
  description = <<EOH
this is the differantiates different demostack deployment on the same subscription, everycluster should have a different value
EOH
default = "guystack"
}

variable "postgres_password" {
  description = "the password for admin username of the MySQL Database we will configure in Vault(this will be rotated after config)"
default = "YourPwdShouldBeLongAndSecure!"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2"
}
