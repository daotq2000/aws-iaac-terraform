resource "aws_codebuild_project" "example" {
  name          = "aws-iaac-project"
  description   = "Project for AWS CodeBuild"
  build_timeout = "5"  # Duration in minutes
  service_role  = var.aws_role_code_pipeline  # Ensure you've defined the IAM role resource

  artifacts {
    type = "S3"
    artifact_identifier = aws_s3_bucket.bucket_data
  }

  environment {
    compute_type                = "Lambda"  # Replace with your preferred type
    image                       = "Java"  # Replace with your preferred image
    type                        = "Amazon Linux"
    image_pull_credentials_type = "aws/codebuild/amazonlinux-aarch64-lambda-standard:corretto11"
    registry_credential {
      credential          = var.registry_credential
      credential_provider = var.registry_credential_provider
    }
    environment_variable {
      name  = ""
      value = ""
    }
  }

  source {
    type      = var.repository.source
    location  = var.repository.url
  }

}