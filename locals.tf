locals {
  // Add parent namespace_id to the repo if namespace_parent name is provided
  groups_repos = { for repo_path, repo_val in var.groups_repos : repo_path => {
    for key, val in repo_val : key => merge(
      val,
      key == "config" && can(val.namespace_name)
      ? { namespace_id = module.groups[val.namespace_name].group_id }
      : {}
    )
    }
  }
}

locals {
  // Add parent namespace_id to the repo if namespace_name name is provided
  subgroups_repos = { for repo_path, repo_val in var.subgroups_repos : repo_path => {
    for key, val in repo_val : key => merge(
      val,
      key == "config" && can(val.namespace_name)
      ? { namespace_id = module.subgroups[val.namespace_name].group_id }
      : {}
    )
    }
  }
}

locals {
  // Add parent namespace_id to the repo if namespace_name name is provided
  subgroups = { for subgroup_path, subgroup_val in var.subgroups : subgroup_path => merge([
    for group_key, group_val in var.groups : {
      for key, val in subgroup_val : key => merge(
        val,
        key == "config" && var.groups[group_key].subgroups[subgroup_path] != null
        ? { parent_id = module.groups[group_key].group_id }
        : {}
      )
    }
    # subgroup_key => merge(
    #   val,
    #   key == "config" && can(val.namespace_name)
    #   ? { parent_id = module.groups[val.namespace_name].group_id }
    #   : {}
    # )
    # }
    ]...)
  }
}
