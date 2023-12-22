# Configure the GitLab Provider
terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>16.0"
    }
  }
}
