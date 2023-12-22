locals {
  // Add parent namespace_id to the repo if namespace_parent name is provided
  groups_repos = { for repo_path, repo_val in var.groups_repos : repo_path => {
    for key, val in repo_val : key => merge(
      val,
      key == "config" && can(val.namespace_name) ? { namespace_id = module.groups[val.namespace_name].group_id } : {}
    )
    }
  }
}

locals {
  // Add parent namespace_id to the repo if namespace_name name is provided
  subgroups_repos = { for repo_path, repo_val in var.subgroups_repos : repo_path => {
    for key, val in repo_val : key => merge(
      val,
      key == "config" && can(val.namespace_name) ? { namespace_id = module.subgroups[val.namespace_name].group_id } : {}
    )
    }
  }
}
