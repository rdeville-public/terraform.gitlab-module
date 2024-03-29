module "groups" {
  source   = "./groups"
  for_each = var.groups

  group               = each.value.config
  group_labels        = try(each.value.labels, {})
  group_variables     = try(each.value.variables, {})
  group_access_tokens = try(each.value.access_tokens, {})
}

module "groups_repos" {
  source   = "./repos"
  for_each = local.groups_repos

  repo                   = each.value.config
  repo_labels            = each.value.labels
  repo_branch_protection = each.value.branch_protections
  repo_tag_protections   = each.value.tag_protections
  repo_variables         = each.value.variables
  repo_access_tokens     = each.value.access_tokens
  repo_mirrors           = each.value.mirrors
}

module "subgroups" {
  source   = "./groups"
  for_each = local.subgroups

  group               = each.value.config
  group_labels        = try(each.value.labels, {})
  group_variables     = try(each.value.variables, {})
  group_access_tokens = try(each.value.access_tokens, {})
}

module "subgroups_repos" {
  source   = "./repos"
  for_each = local.subgroups_repos

  repo                   = each.value.config
  repo_labels            = each.value.labels
  repo_branch_protection = each.value.branch_protections
  repo_tag_protections   = each.value.tag_protections
  repo_variables         = each.value.variables
  repo_access_tokens     = each.value.access_tokens
  repo_mirrors           = each.value.mirrors
}

module "user" {
  source = "./user"

  user_sshkeys       = var.user.sshkeys
  user_gpgkeys       = var.user.gpgkeys
  user_access_tokens = var.user.access_tokens
}

module "user_repos" {
  source   = "./repos"
  for_each = var.user_repos

  repo                   = each.value.config
  repo_labels            = each.value.labels
  repo_branch_protection = each.value.branch_protections
  repo_tag_protections   = each.value.tag_protections
  repo_variables         = each.value.variables
  repo_access_tokens     = each.value.access_tokens
  repo_mirrors           = each.value.mirrors
}

