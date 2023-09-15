terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  owner = "Practical-DevOps-GitHub"
  token = var.token
}

resource "github_repository_collaborator" "a_repo_collaborator" {
  repository = "terraform-examples"
  username   = "softservedata"
  permission = "admin"
}


resource "github_branch" "develop" {
  repository = "terraform-examples"
  branch     = "github"
}


resource "github_branch_default" "default" {
  repository = "terraform-examples"
  branch     = github_branch.develop.branch
}


variable "token" {
  default = "abcabc"
}


resource "github_branch_protection" "terraform-examples" {
  repository_id = "terraform-examples"
  pattern       = "github"
  required_pull_request_reviews {
    require_code_owner_reviews      = true
    required_approving_review_count = 0
  }

}

resource "github_branch_protection" "example2" {
  repository_id = "terraform-examples"
  pattern       = "develop"
  required_pull_request_reviews {
    required_approving_review_count = 2
  }

}

resource "github_repository_file" "codeowners" {
  repository          = "terraform-examples"
  branch              = "main"
  file                = ".github/CODEOWNERS"
  content             = "* @softservedata"
  commit_message      = "Add CODEOWNERS"
  overwrite_on_create = true
}

resource "github_repository_deploy_key" "example_repository_deploy_key" {
  title      = "DEPLOY_KEY"
  repository = "terraform-examples"
  key        = "ssh-ed25519 AAAA..."
  read_only  = "true"
}

resource "github_repository_webhook" "foo" {
  repository = "terraform-examples"
  
  configuration {
    url          = "https://discord.com/api/webhooks/113..."
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["pull_request"]
}

resource "github_actions_secret" "example_secret" {
  repository      = "terraform-examples"
  secret_name     = "PAT"
  plaintext_value = var.token
}
