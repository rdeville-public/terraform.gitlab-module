# Groups Variables
# ----------------------------------------------------------------------------
# See ./groups/variable.tf
variable "groups" {
  type = map(object({
    // Key are group path
    config        = optional(map(any))
    labels        = optional(map(any))
    variables     = optional(map(any))
    access_tokens = optional(map(any))
    subgroups     = optional(map(any))
  }))

  description = "Object describing a gitlab group configuration, variables, labels and access_tokens."
}

variable "subgroups" {
  type = map(object({
    // Key are subgroup path
    config        = optional(map(any))
    labels        = optional(map(any))
    variables     = optional(map(any))
    access_tokens = optional(map(any))
  }))

  default = {}
}

# Projects Variables
# ----------------------------------------------------------------------------
# See ./user/variable.tf
variable "user" {
  type = object({
    sshkeys       = optional(map(any))
    gpgkeys       = optional(map(any))
    access_tokens = optional(map(any))
  })

  default = {}
}

# Projects Variables
# ----------------------------------------------------------------------------
# See ./projects/variable.tf
variable "groups_repos" {
  type = map(object({
    config             = optional(map(any))
    labels             = optional(map(any))
    variables          = optional(map(any))
    branch_protections = optional(map(any))
    tag_protections    = optional(map(any))
    access_tokens      = optional(map(any))
    mirrors            = optional(map(any))
  }))
  default = {}
}

variable "subgroups_repos" {
  type = map(object({
    config             = optional(map(any))
    labels             = optional(map(any))
    variables          = optional(map(any))
    branch_protections = optional(map(any))
    tag_protections    = optional(map(any))
    access_tokens      = optional(map(any))
    mirrors            = optional(map(any))
  }))

  default = {}
}

variable "user_repos" {
  type = map(object({
    config             = optional(map(any))
    labels             = optional(map(any))
    variables          = optional(map(any))
    branch_protections = optional(map(any))
    tag_protections    = optional(map(any))
    access_tokens      = optional(map(any))
    mirrors            = optional(map(any))
  }))
  default = {}
}
