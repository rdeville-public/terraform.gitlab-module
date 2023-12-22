resource "gitlab_group" "this" {
  path        = var.group.path
  name        = var.group.name
  description = var.group.description
  parent_id   = var.group.parent_id

  auto_devops_enabled               = var.group.auto_devops_enabled
  default_branch_protection         = var.group.default_branch_protection
  emails_disabled                   = var.group.emails_disabled
  lfs_enabled                       = var.group.lfs_enabled
  membership_lock                   = var.group.membership_lock
  mentions_disabled                 = var.group.mentions_disabled
  prevent_forking_outside_group     = var.group.prevent_forking_outside_group
  project_creation_level            = var.group.project_creation_level
  request_access_enabled            = var.group.request_access_enabled
  require_two_factor_authentication = var.group.require_two_factor_authentication
  share_with_group_lock             = var.group.share_with_group_lock
  shared_runners_setting            = var.group.shared_runners_setting
  subgroup_creation_level           = var.group.subgroup_creation_level
  two_factor_grace_period           = var.group.two_factor_grace_period
  visibility_level                  = var.group.visibility_level
  wiki_access_level                 = var.group.wiki_access_level
  dynamic "push_rules" {
    for_each = can(var.group.push_rules) ? [1] : []
    content {
      branch_name_regex       = try(var.group.push_rules.branch_name_regex, null)
      commit_committer_check  = try(var.group.push_rules.commit_committer_check, null)
      deny_delete_tag         = try(var.group.push_rules.deny_delete_tag, null)
      max_file_size           = try(var.group.push_rules.max_file_size, null)
      member_check            = try(var.group.push_rules.member_check, null)
      prevent_secrets         = try(var.group.push_rules.prevent_secrets, null)
      reject_unsigned_commits = try(var.group.push_rules.reject_unsigned_commits, null)
    }
  }

  lifecycle {
    ignore_changes = [
      push_rules
    ]
  }
}

resource "gitlab_group_label" "this" {
  for_each = var.group_labels != null ? var.group_labels : {}

  group       = gitlab_group.this.id
  name        = each.key
  color       = each.value.color
  description = each.value.description
}

resource "gitlab_group_variable" "this" {
  for_each = var.group_variables != null ? var.group_variables : {}

  group = gitlab_group.this.name
  key   = each.key
  value = each.value.value
}

resource "gitlab_group_access_token" "this" {
  for_each = var.group_access_tokens != null ? var.group_access_tokens : {}

  group      = gitlab_group.this.name
  name       = each.key
  expires_at = each.value.expires_at
  scopes     = each.value.scopes
}
