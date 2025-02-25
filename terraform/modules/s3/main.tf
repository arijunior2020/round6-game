resource "aws_s3_bucket" "codepipeline_bucket" {
    bucket = "round6-game-codepipeline-bucket"
}

output "s3_bucket_id" {
    value = aws_s3_bucket.codepipeline_bucket.id
}
