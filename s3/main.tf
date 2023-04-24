resource "aws_s3_bucket" "s3" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
  }
}