data "gitlab_current_user" "this" {}

data "gitlab_users" "current_user" {
  search = data.gitlab_current_user.this.username
}
