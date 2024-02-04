variable "group" {
  type = object({
    path        = string
    name        = string
    parent_id   = optional(number)
    description = optional(string)
    avatar_hash = optional(string)

    auto_devops_enabled               = optional(bool, false)
    default_branch_protection         = optional(number, 4)
    emails_disabled                   = optional(bool, true)
    lfs_enabled                       = optional(bool, false)
    membership_lock                   = optional(bool, true)
    mentions_disabled                 = optional(bool, true)
    prevent_forking_outside_group     = optional(bool)
    project_creation_level            = optional(string, "maintainer")
    request_access_enabled            = optional(bool, false)
    require_two_factor_authentication = optional(bool, true)
    share_with_group_lock             = optional(bool, true)
    shared_runners_setting            = optional(string, "disabled_and_unoverridable")
    subgroup_creation_level           = optional(string, "maintainer")
    two_factor_grace_period           = optional(number, 72)
    visibility_level                  = optional(string, "private")
    wiki_access_level                 = optional(string)

    push_rules = optional(object({
      branch_name_regex       = optional(string)
      commit_committer_check  = optional(bool)
      deny_delete_tag         = optional(bool)
      max_file_size           = optional(string)
      member_check            = optional(bool)
      prevent_secrets         = optional(bool)
      reject_unsigned_commits = optional(bool)
    }), {})
  })
}

variable "group_labels" {
  type = map(object({
    color       = string
    description = optional(string)
  }))

  default = {}
}

variable "group_variables" {
  type = map(object({
    value             = string
    environment_scope = optional(string)
    masked            = optional(bool)
    protected         = optional(bool)
    raw               = optional(bool)
    variable_type     = optional(string)
  }))
  default = {}

}

variable "group_access_tokens" {
  type = map(object({
    expires_at   = string
    scopes       = list(string)
    access_level = optional(string)
  }))

  default = {}
}
