output "repos" {
  value = merge(
    module.groups_repos,
    module.subgroups_repos,
    module.user_repos
  )
}

output "groups" {
  value = merge(
    module.groups,
    module.subgroups
  )
}

output "user" {
  value = module.user
}
