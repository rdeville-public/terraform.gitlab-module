variable "repo" {
  // Key of map is path of repo
  type = object({
    path         = string
    name         = optional(string, null)
    namespace_id = optional(number, null)
    description  = optional(string, null)
    avatar_hash  = optional(string, null)

    allow_merge_on_skipped_pipeline             = optional(bool, false)
    analytics_access_level                      = optional(string, "disabled")
    archive_on_destroy                          = optional(bool, false)
    archived                                    = optional(bool, false)
    auto_cancel_pending_pipelines               = optional(string, "enabled")
    auto_devops_deploy_strategy                 = optional(string, "manual")
    auto_devops_enabled                         = optional(bool, false)
    autoclose_referenced_issues                 = optional(bool, true)
    build_git_strategy                          = optional(string, "clone")
    build_timeout                               = optional(number, 3600)
    builds_access_level                         = optional(string, "disabled")
    ci_config_path                              = optional(string, null)
    ci_default_git_depth                        = optional(number)
    ci_forward_deployment_enabled               = optional(bool, true)
    ci_separated_caches                         = optional(bool, true)
    default_branch                              = optional(string, "main")
    emails_disabled                             = optional(bool, true)
    environments_access_level                   = optional(string, "disabled")
    external_authorization_classification_label = optional(string, null)
    feature_flags_access_level                  = optional(string, "disabled")
    forked_from_project_id                      = optional(number, null)
    forking_access_level                        = optional(string, null)
    group_with_project_templates_id             = optional(number, null)
    import_url                                  = optional(string, null)
    import_url_password                         = optional(string, null)
    import_url_username                         = optional(string, null)
    infrastructure_access_level                 = optional(string, "disabled")
    initialize_with_readme                      = optional(bool, false)
    issues_access_level                         = optional(string, "disabled")
    issues_enabled                              = optional(bool, false)
    issues_template                             = optional(string, null)
    keep_latest_artifact                        = optional(bool, true)
    lfs_enabled                                 = optional(bool, false)
    merge_commit_template = optional(string, <<EOT
Merge branch '%%{source_branch}' into '%%{target_branch}'

%%{title}

%%{description}

%%{issues}

%%{reviewed_by}
%%{approved_by}
%%{merged_by}

See merge request %%{url}
EOT
    )
    merge_method                                     = optional(string, "rebase_merge")
    merge_pipelines_enabled                          = optional(bool, false)
    merge_requests_access_level                      = optional(string, "disabled")
    merge_requests_enabled                           = optional(bool, false)
    merge_requests_template                          = optional(string, null)
    merge_trains_enabled                             = optional(bool, true)
    mirror                                           = optional(bool, null)
    mirror_overwrites_diverged_branches              = optional(bool, null)
    mirror_trigger_builds                            = optional(bool, null)
    monitor_access_level                             = optional(string, "disabled")
    mr_default_target_self                           = optional(bool, null)
    only_allow_merge_if_all_discussions_are_resolved = optional(bool, true)
    only_allow_merge_if_pipeline_succeeds            = optional(bool, true)
    only_mirror_protected_branches                   = optional(bool, null)
    packages_enabled                                 = optional(bool, false)
    pages_access_level                               = optional(string, "disabled")
    printing_merge_request_link_enabled              = optional(bool, true)
    public_jobs                                      = optional(bool, false)
    releases_access_level                            = optional(string, "disabled")
    remove_source_branch_after_merge                 = optional(bool, true)
    repository_access_level                          = optional(string, "disabled")
    repository_storage                               = optional(string, null)
    request_access_enabled                           = optional(bool, false)
    requirements_access_level                        = optional(string, "disabled")
    resolve_outdated_diff_discussions                = optional(bool, false)
    restrict_user_defined_variables                  = optional(bool, true)
    security_and_compliance_access_level             = optional(string, "disabled")
    shared_runners_enabled                           = optional(bool, false)
    skip_wait_for_default_branch_protection          = optional(bool, false)
    snippets_access_level                            = optional(string, "disabled")
    snippets_enabled                                 = optional(bool, false)
    squash_commit_template = optional(string, <<EOT
%%{title}

%%{description}

%%{issues}

EOT
    )
    squash_option             = optional(string, "default_off")
    suggestion_commit_message = optional(string, null)
    template_name             = optional(string, null)
    template_project_id       = optional(number, null)
    topics                    = optional(list(string), null)
    use_custom_template       = optional(bool, false)
    visibility_level          = optional(string, "private")
    wiki_access_level         = optional(string, "disabled")
    wiki_enabled              = optional(bool, false)

    container_expiration_policy = optional(object({
      cadence           = optional(string, null)
      enabled           = optional(bool, null)
      keep_n            = optional(number, null)
      name_regex_delete = optional(string, null)
      name_regex_keep   = optional(string, null)
      older_than        = optional(string, null)
    }), null)

    push_rules = optional(object({
      author_email_regex            = optional(string, null)
      branch_name_regex             = optional(string, null)
      commit_committer_check        = optional(bool, null)
      commit_message_negative_regex = optional(string, null)
      commit_message_regex          = optional(string, null)
      deny_delete_tag               = optional(bool, null)
      file_name_regex               = optional(string, null)
      max_file_size                 = optional(number, null)
      member_check                  = optional(bool, null)
      prevent_secrets               = optional(bool, null)
      reject_unsigned_commits       = optional(bool, null)
    }), null)
  })
}

variable "repo_labels" {
  type = map(object({
    // Key is label name
    color       = string
    description = optional(string)
  }))

  default = {}
}

variable "repo_variables" {
  type = map(object({
    // Key is variable name
    value             = string
    environment_scope = optional(string)
    masked            = optional(bool)
    protected         = optional(bool)
    raw               = optional(bool)
    variable_type     = optional(string)
  }))

  default = {}
}

variable "repo_tag_protections" {
  type = map(object({
    tag                 = optional(string)
    create_access_level = optional(string)
    allowed_to_create = optional(list(object({
      user_id  = optional(number)
      group_id = optional(number)
    })), null)
  }))

  default = {}
}

variable "repo_access_tokens" {
  type = map(object({
    // Key is access token name
    expires_at   = string
    scopes       = list(string)
    access_level = optional(string)
  }))
  default = {}
}

variable "repo_mirrors" {
  type = map(object({
    // Key is just an identifier
    url                     = string
    enabled                 = optional(bool, true)
    keep_divergent_refs     = optional(bool, false)
    only_protected_branches = optional(bool, true)
  }))

  default = {}
}
