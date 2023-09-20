data "aws_region" "current" {}

data "aws_canonical_user_id" "this" {
  count = local.create_bucket && local.create_bucket_acl && try(var.owner["id"], null) == null ? 1 : 0
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

