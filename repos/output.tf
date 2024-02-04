output "ssh_url" {
  value = gitlab_project.this.ssh_url_to_repo
}

output "http_url" {
  value = gitlab_project.this.http_url_to_repo
}

output "path_with_namespace" {
  value = gitlab_project.this.path_with_namespace
}

