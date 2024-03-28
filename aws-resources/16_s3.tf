
resource "aws_s3_bucket" "bucket_front_end_source" {
  bucket = "bucket_front_end_source"
}
resource "aws_s3_bucket" "bucket_data" {
  bucket = "bucket_data"
}