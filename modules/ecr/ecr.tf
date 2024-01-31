resource "aws_ecr_repository" "private_repo" {
  name = var.ecr_repo_name

  image_tag_mutability = var.repository_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.repository_image_scan_on_push
  }
  tags = var.ecr_repo_tags

}