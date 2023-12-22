resource "gitlab_user_sshkey" "this" {
  for_each = var.user_sshkeys != null ? var.user_sshkeys : {}

  user_id    = data.gitlab_current_user.this.id
  title      = each.key
  key        = each.value.key
  expires_at = each.value.expires_at
}

resource "gitlab_user_gpgkey" "this" {
  for_each = var.user_gpgkeys != null ? var.user_gpgkeys : {}

  user_id = data.gitlab_current_user.this.id
  key     = each.value.key
}

resource "gitlab_personal_access_token" "this" {
  for_each = var.user_access_tokens != null ? var.user_access_tokens : {}

  user_id    = data.gitlab_current_user.this.id
  name       = each.key
  expires_at = each.value.expires_at
  scopes     = each.value.scopes

  lifecycle {
    precondition {
      condition     = data.gitlab_users.current_user.users[0].is_admin
      error_message = "Current user MUST be an Administrator of this Gitlab server."
    }
  }
}
