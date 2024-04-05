#resource "aws_codebuild_project" "aws-iaac-project" {
#  name          = "aws-iaac-project"
#  description   = "Project for AWS CodeBuild"
#  build_timeout = "5"  # Duration in minutes
#  service_role  = var.aws_role_code_pipeline  # Ensure you've defined the IAM role resource
#
#  artifacts {
#    type = "S3"
#    artifact_identifier = aws_s3_bucket.eks-project-bucket-data.bucket
#  }
#
#  environment {
#    compute_type                = "BUILD_GENERAL1_SMALL"  # Replace with your preferred type
#    image                       = "LINUX_CONTAINER"  # Replace with your preferred image
#    type                        = "LINUX_CONTAINER"
#    image_pull_credentials_type = "SERVICE_ROLE"
#    registry_credential {
#      credential_provider = "SECRETS_MANAGER"
#      credential          = var.registry_credential
#    }
#  }
#
#  source {
#    type      = "S3"
#    location  = "s3://${aws_s3_bucket.eks-project-front-end-source.bucket_regional_domain_name}/"
#  }
#
#}