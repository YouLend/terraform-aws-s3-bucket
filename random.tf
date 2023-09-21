resource "random_id" "server" {
  count       = local.create_logging_bucket ? 1 : 0
  byte_length = 8
}
