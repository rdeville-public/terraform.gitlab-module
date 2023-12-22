variable "user_gpgkeys" {
  // Key is just an identifier for the GPG Key
  type = map(string)

  default = {}
}

variable "user_sshkeys" {
  // Key is the title of the SSH Key
  type = map(object({
    key        = string,
    expires_at = string
  }))

  default = {}
}

variable "user_access_tokens" {
  // Key is the name of the access token
  type = map(object({
    expires_at = string
    scopes     = list(string)
  }))

  default = {}
}
