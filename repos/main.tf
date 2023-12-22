resource "gitlab_project" "this" {
  path         = var.repo.path
  name         = var.repo.name
  namespace_id = var.repo.namespace_id
  description  = var.repo.description

  allow_merge_on_skipped_pipeline                  = var.repo.allow_merge_on_skipped_pipeline
  analytics_access_level                           = var.repo.analytics_access_level
  archive_on_destroy                               = var.repo.archive_on_destroy
  archived                                         = var.repo.archived
  auto_cancel_pending_pipelines                    = var.repo.auto_cancel_pending_pipelines
  auto_devops_deploy_strategy                      = var.repo.auto_devops_deploy_strategy
  auto_devops_enabled                              = var.repo.auto_devops_enabled
  autoclose_referenced_issues                      = var.repo.autoclose_referenced_issues
  build_git_strategy                               = var.repo.build_git_strategy
  build_timeout                                    = var.repo.build_timeout
  builds_access_level                              = var.repo.builds_access_level
  ci_config_path                                   = var.repo.ci_config_path
  ci_default_git_depth                             = var.repo.ci_default_git_depth
  ci_forward_deployment_enabled                    = var.repo.ci_forward_deployment_enabled
  ci_separated_caches                              = var.repo.ci_separated_caches
  default_branch                                   = var.repo.default_branch
  emails_disabled                                  = var.repo.emails_disabled
  environments_access_level                        = var.repo.environments_access_level
  external_authorization_classification_label      = var.repo.external_authorization_classification_label
  feature_flags_access_level                       = var.repo.feature_flags_access_level
  forked_from_project_id                           = var.repo.forked_from_project_id
  forking_access_level                             = var.repo.forking_access_level
  group_with_project_templates_id                  = var.repo.group_with_project_templates_id
  import_url                                       = var.repo.import_url
  import_url_password                              = var.repo.import_url_password
  import_url_username                              = var.repo.import_url_username
  infrastructure_access_level                      = var.repo.infrastructure_access_level
  initialize_with_readme                           = var.repo.initialize_with_readme
  issues_access_level                              = var.repo.issues_access_level
  issues_enabled                                   = var.repo.issues_enabled
  issues_template                                  = var.repo.issues_template
  keep_latest_artifact                             = var.repo.keep_latest_artifact
  lfs_enabled                                      = var.repo.lfs_enabled
  merge_commit_template                            = var.repo.merge_commit_template
  merge_method                                     = var.repo.merge_method
  merge_pipelines_enabled                          = var.repo.merge_pipelines_enabled
  merge_requests_access_level                      = var.repo.merge_requests_access_level
  merge_requests_enabled                           = var.repo.merge_requests_enabled
  merge_requests_template                          = var.repo.merge_requests_template
  merge_trains_enabled                             = var.repo.merge_trains_enabled
  mirror                                           = var.repo.mirror
  mirror_overwrites_diverged_branches              = var.repo.mirror_overwrites_diverged_branches
  mirror_trigger_builds                            = var.repo.mirror_trigger_builds
  monitor_access_level                             = var.repo.monitor_access_level
  mr_default_target_self                           = var.repo.mr_default_target_self
  only_allow_merge_if_all_discussions_are_resolved = var.repo.only_allow_merge_if_all_discussions_are_resolved
  only_allow_merge_if_pipeline_succeeds            = var.repo.only_allow_merge_if_pipeline_succeeds
  only_mirror_protected_branches                   = var.repo.only_mirror_protected_branches
  packages_enabled                                 = var.repo.packages_enabled
  pages_access_level                               = var.repo.pages_access_level
  printing_merge_request_link_enabled              = var.repo.printing_merge_request_link_enabled
  public_jobs                                      = var.repo.public_jobs
  releases_access_level                            = var.repo.releases_access_level
  remove_source_branch_after_merge                 = var.repo.remove_source_branch_after_merge
  repository_access_level                          = var.repo.repository_access_level
  repository_storage                               = var.repo.repository_storage
  request_access_enabled                           = var.repo.request_access_enabled
  requirements_access_level                        = var.repo.requirements_access_level
  resolve_outdated_diff_discussions                = var.repo.resolve_outdated_diff_discussions
  restrict_user_defined_variables                  = var.repo.restrict_user_defined_variables
  security_and_compliance_access_level             = var.repo.security_and_compliance_access_level
  shared_runners_enabled                           = var.repo.shared_runners_enabled
  skip_wait_for_default_branch_protection          = var.repo.skip_wait_for_default_branch_protection
  snippets_access_level                            = var.repo.snippets_access_level
  snippets_enabled                                 = var.repo.snippets_enabled
  squash_commit_template                           = var.repo.squash_commit_template
  squash_option                                    = var.repo.squash_option
  suggestion_commit_message                        = var.repo.suggestion_commit_message
  template_name                                    = var.repo.template_name
  template_project_id                              = var.repo.template_project_id
  topics                                           = var.repo.topics
  use_custom_template                              = var.repo.use_custom_template
  visibility_level                                 = var.repo.visibility_level
  wiki_access_level                                = var.repo.wiki_access_level

  dynamic "container_expiration_policy" {
    for_each = can(var.repo.container_expiration_policy) ? [1] : null

    content {
      cadence           = try(var.repo.container_expiration_policy.cadence, null)
      enabled           = try(var.repo.container_expiration_policy.enabled, null)
      keep_n            = try(var.repo.container_expiration_policy.keep_n, null)
      name_regex_delete = try(var.repo.container_expiration_policy.name_regex_delete, null)
      name_regex_keep   = try(var.repo.container_expiration_policy.name_regex_keep, null)
      older_than        = try(var.repo.container_expiration_policy.older_than, null)
    }
  }

  dynamic "push_rules" {
    for_each = can(var.repo.push_rules) ? [1] : null

    content {
      branch_name_regex       = try(var.repo.push_rules.branch_name_regex, null)
      commit_committer_check  = try(var.repo.push_rules.commit_committer_check, null)
      deny_delete_tag         = try(var.repo.push_rules.deny_delete_tag, null)
      max_file_size           = try(var.repo.push_rules.max_file_size, null)
      member_check            = try(var.repo.push_rules.member_check, null)
      prevent_secrets         = try(var.repo.push_rules.prevent_secrets, null)
      reject_unsigned_commits = try(var.repo.push_rules.reject_unsigned_commits, null)
    }
  }

  lifecycle {
    ignore_changes = [
      push_rules
    ]
  }
}

resource "gitlab_tag_protection" "this" {
  for_each = var.repo_tag_protections


  project             = gitlab_project.this.id
  create_access_level = each.value.create_access_level
  tag                 = each.value.tag
  dynamic "allowed_to_create" {
    for_each = each.value.allowed_to_create

    content {
      user_id  = each.value.user_id
      group_id = each.value.group_id
    }
  }
}

resource "gitlab_project_label" "this" {
  for_each = var.repo_labels

  name        = each.key
  color       = each.value.color
  project     = gitlab_project.this.id
  description = each.value.description
}

resource "gitlab_project_variable" "this" {
  for_each = var.repo_variables

  key     = each.key
  value   = each.value.value
  project = gitlab_project.this.id
}

resource "gitlab_project_access_token" "this" {
  for_each = var.repo_access_tokens

  project    = gitlab_project.this.id
  name       = each.key
  expires_at = each.value.expires_at
  scopes     = each.value.scopes
}

resource "gitlab_project_mirror" "this" {
  for_each = var.repo_mirrors

  project                 = gitlab_project.this.id
  url                     = each.value.url
  enabled                 = each.value.enabled
  keep_divergent_refs     = each.value.keep_divergent_refs
  only_protected_branches = each.value.only_protected_branches
}
