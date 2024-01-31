variable "ecr_repo_name" {
  type = string 
  description = "ECR repository name"
}

variable "ecr_repo_tags" {
  type = map(string)
  description = "List of tags associated with the repository"
}

variable "repository_image_tag_mutability" {
  type = string
  description = "mutability setting for the repository"
}

variable "repository_image_scan_on_push" {
  type = bool
  description = "Indicates whether images are scanned after being pushed to the repository (`true`) or not scanned (`false`)"
}