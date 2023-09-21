locals {
  create_bucket                          = var.create_bucket
  create_logging_bucket                  = var.create_logging_bucket
  logging_bucket_name                    = try("${var.logging_bucket_name}-${random_id.server[0].hex}", "")
  logging_bucket_role_name               = "s3_bucket_role-${var.logging_bucket_name}"
  logging_bucket_replication_role_name   = "s3_replication_role-${var.logging_bucket_name}"
  logging_bucket_replication_policy_name = "s3_replication_policy-${var.logging_bucket_name}"

  create_bucket_acl = (var.acl != null && var.acl != "null") || length(local.grants) > 0

  attach_policy = var.attach_require_latest_tls_policy || var.attach_access_log_delivery_policy || var.attach_elb_log_delivery_policy || var.attach_lb_log_delivery_policy || var.attach_deny_insecure_transport_policy || var.attach_inventory_destination_policy || var.attach_deny_incorrect_encryption_headers || var.attach_deny_incorrect_kms_key_sse || var.attach_deny_unencrypted_object_uploads || var.attach_policy

  # Variables with type `any` should be jsonencode()'d when value is coming from Terragrunt
  grants               = try(jsondecode(var.grant), var.grant)
  cors_rules           = try(jsondecode(var.cors_rule), var.cors_rule)
  lifecycle_rules      = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)
  intelligent_tiering  = try(jsondecode(var.intelligent_tiering), var.intelligent_tiering)
  metric_configuration = try(jsondecode(var.metric_configuration), var.metric_configuration)
}
