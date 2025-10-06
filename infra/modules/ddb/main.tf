resource "aws_kms_key" "ddb" {
  description = "${var.project_name}-${var.environment}-ddb-kms"
  enable_key_rotation = true
  deletion_window_in_days = 7
  tags = var.tags
}
resource "aws_dynamodb_table" "occupancy" {
  name         = "${var.project_name}-${var.environment}-occupancy"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "unit_id"
  server_side_encryption { enabled = true, kms_key_arn = aws_kms_key.ddb.arn }
  attribute { name = "unit_id" type = "S" }
  tags = merge(var.tags, { Component = "dynamodb" })
}
output "table_name" { value = aws_dynamodb_table.occupancy.name }
output "arn"        { value = aws_dynamodb_table.occupancy.arn }
