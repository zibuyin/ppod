#!/usr/bin/env bash

curl -X POST http://localhost:8000/webhook \
      -H "Content-Type: application/json" \
      -H "User-Agent: GitHub-Hookshot/d97595e" \
      -H "X-GitHub-Delivery: 7917ec6a-351d-11f1-9ac6-8cf28616deb8" \
      -H "X-GitHub-Event: push" \
      -H "X-GitHub-Hook-ID: 605551387" \
      -H "X-GitHub-Hook-Installation-Target-ID: 1196546778" \
      -H "X-GitHub-Hook-Installation-Target-Type: repository" \
      -H "X-Hub-Signature: sha1=cc977d3b7d1e1e949bb0c16bcf48b9646f86047c" \
      -H "x-hub-signature-256: sha256=3073d0e5cccc508106c57bffcbd58914bc900abb1862b816295283edaabaf27d" \
      --data-binary @- <<'JSON'
{
      "ref": "refs/heads/main",
      "before": "4c323db4a6d2fce4f6b0d3f7f9ec4b7f6d86f111",
      "after": "8d34f1c9a2b7e48f4fc8d629a1f0e2dc2c3a9abc",
      "repository": {
            "id": 812345678,
            "node_id": "R_kgDOTest01",
            "name": "auto_deploy",
            "full_name": "nathanyin/auto_deploy",
            "private": true,
            "owner": {
                  "name": "nathanyin",
                  "email": "nathan@example.com",
                  "login": "nathanyin",
                  "id": 1196546778,
                  "node_id": "U_kgDOOwner01",
                  "avatar_url": "https://avatars.githubusercontent.com/u/1196546778?v=4",
                  "gravatar_id": "",
                  "url": "https://api.github.com/users/nathanyin",
                  "html_url": "https://github.com/nathanyin",
                  "followers_url": "https://api.github.com/users/nathanyin/followers",
                  "following_url": "https://api.github.com/users/nathanyin/following{/other_user}",
                  "gists_url": "https://api.github.com/users/nathanyin/gists{/gist_id}",
                  "starred_url": "https://api.github.com/users/nathanyin/starred{/owner}{/repo}",
                  "subscriptions_url": "https://api.github.com/users/nathanyin/subscriptions",
                  "organizations_url": "https://api.github.com/users/nathanyin/orgs",
                  "repos_url": "https://api.github.com/users/nathanyin/repos",
                  "events_url": "https://api.github.com/users/nathanyin/events{/privacy}",
                  "received_events_url": "https://api.github.com/users/nathanyin/received_events",
                  "type": "User",
                  "site_admin": false
            },
            "html_url": "https://github.com/nathanyin/auto_deploy",
            "description": "Webhook endpoint for auto deploy testing",
            "fork": false,
            "url": "https://api.github.com/repos/nathanyin/auto_deploy",
            "forks_url": "https://api.github.com/repos/nathanyin/auto_deploy/forks",
            "keys_url": "https://api.github.com/repos/nathanyin/auto_deploy/keys{/key_id}",
            "collaborators_url": "https://api.github.com/repos/nathanyin/auto_deploy/collaborators{/collaborator}",
            "teams_url": "https://api.github.com/repos/nathanyin/auto_deploy/teams",
            "hooks_url": "https://api.github.com/repos/nathanyin/auto_deploy/hooks",
            "issue_events_url": "https://api.github.com/repos/nathanyin/auto_deploy/issues/events{/number}",
            "events_url": "https://api.github.com/repos/nathanyin/auto_deploy/events",
            "assignees_url": "https://api.github.com/repos/nathanyin/auto_deploy/assignees{/user}",
            "branches_url": "https://api.github.com/repos/nathanyin/auto_deploy/branches{/branch}",
            "tags_url": "https://api.github.com/repos/nathanyin/auto_deploy/tags",
            "blobs_url": "https://api.github.com/repos/nathanyin/auto_deploy/git/blobs{/sha}",
            "git_tags_url": "https://api.github.com/repos/nathanyin/auto_deploy/git/tags{/sha}",
            "git_refs_url": "https://api.github.com/repos/nathanyin/auto_deploy/git/refs{/sha}",
            "trees_url": "https://api.github.com/repos/nathanyin/auto_deploy/git/trees{/sha}",
            "statuses_url": "https://api.github.com/repos/nathanyin/auto_deploy/statuses/{sha}",
            "languages_url": "https://api.github.com/repos/nathanyin/auto_deploy/languages",
            "stargazers_url": "https://api.github.com/repos/nathanyin/auto_deploy/stargazers",
            "contributors_url": "https://api.github.com/repos/nathanyin/auto_deploy/contributors",
            "subscribers_url": "https://api.github.com/repos/nathanyin/auto_deploy/subscribers",
            "subscription_url": "https://api.github.com/repos/nathanyin/auto_deploy/subscription",
            "commits_url": "https://api.github.com/repos/nathanyin/auto_deploy/commits{/sha}",
            "git_commits_url": "https://api.github.com/repos/nathanyin/auto_deploy/git/commits{/sha}",
            "comments_url": "https://api.github.com/repos/nathanyin/auto_deploy/comments{/number}",
            "issue_comment_url": "https://api.github.com/repos/nathanyin/auto_deploy/issues/comments{/number}",
            "contents_url": "https://api.github.com/repos/nathanyin/auto_deploy/contents/{+path}",
            "compare_url": "https://api.github.com/repos/nathanyin/auto_deploy/compare/{base}...{head}",
            "merges_url": "https://api.github.com/repos/nathanyin/auto_deploy/merges",
            "archive_url": "https://api.github.com/repos/nathanyin/auto_deploy/{archive_format}{/ref}",
            "downloads_url": "https://api.github.com/repos/nathanyin/auto_deploy/downloads",
            "issues_url": "https://api.github.com/repos/nathanyin/auto_deploy/issues{/number}",
            "pulls_url": "https://api.github.com/repos/nathanyin/auto_deploy/pulls{/number}",
            "milestones_url": "https://api.github.com/repos/nathanyin/auto_deploy/milestones{/number}",
            "notifications_url": "https://api.github.com/repos/nathanyin/auto_deploy/notifications{?since,all,participating}",
            "labels_url": "https://api.github.com/repos/nathanyin/auto_deploy/labels{/name}",
            "releases_url": "https://api.github.com/repos/nathanyin/auto_deploy/releases{/id}",
            "deployments_url": "https://api.github.com/repos/nathanyin/auto_deploy/deployments",
            "created_at": 1712870400,
            "updated_at": "2026-04-11T10:15:00Z",
            "pushed_at": 1775902500,
            "git_url": "git://github.com/nathanyin/auto_deploy.git",
            "ssh_url": "git@github.com:nathanyin/auto_deploy.git",
            "clone_url": "https://github.com/nathanyin/auto_deploy.git",
            "svn_url": "https://github.com/nathanyin/auto_deploy",
            "homepage": null,
            "size": 42,
            "stargazers_count": 0,
            "watchers_count": 0,
            "language": "JavaScript",
            "has_issues": true,
            "has_projects": true,
            "has_downloads": true,
            "has_wiki": false,
            "has_pages": false,
            "has_discussions": false,
            "forks_count": 0,
            "mirror_url": null,
            "archived": false,
            "disabled": false,
            "open_issues_count": 0,
            "license": null,
            "allow_forking": false,
            "is_template": false,
            "web_commit_signoff_required": false,
            "topics": [],
            "visibility": "private",
            "forks": 0,
            "open_issues": 0,
            "watchers": 0,
            "default_branch": "main",
            "stargazers": 0,
            "master_branch": "main"
      },
      "pusher": {
            "name": "nathanyin",
            "email": "nathan@example.com"
      },
      "sender": {
            "login": "nathanyin",
            "id": 1196546778,
            "node_id": "U_kgDOOwner01",
            "avatar_url": "https://avatars.githubusercontent.com/u/1196546778?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/nathanyin",
            "html_url": "https://github.com/nathanyin",
            "followers_url": "https://api.github.com/users/nathanyin/followers",
            "following_url": "https://api.github.com/users/nathanyin/following{/other_user}",
            "gists_url": "https://api.github.com/users/nathanyin/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/nathanyin/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/nathanyin/subscriptions",
            "organizations_url": "https://api.github.com/users/nathanyin/orgs",
            "repos_url": "https://api.github.com/users/nathanyin/repos",
            "events_url": "https://api.github.com/users/nathanyin/events{/privacy}",
            "received_events_url": "https://api.github.com/users/nathanyin/received_events",
            "type": "User",
            "site_admin": false
      },
      "created": false,
      "deleted": false,
      "forced": false,
      "base_ref": null,
      "compare": "https://github.com/nathanyin/auto_deploy/compare/4c323db4a6d2...8d34f1c9a2b7",
      "commits": [
            {
                  "id": "8d34f1c9a2b7e48f4fc8d629a1f0e2dc2c3a9abc",
                  "tree_id": "f6c675d9f3f884d9bdb6ef66f53f5d7400973abc",
                  "distinct": true,
                  "message": "Add webhook logging for push events",
                  "timestamp": "2026-04-11T10:14:32Z",
                  "url": "https://github.com/nathanyin/auto_deploy/commit/8d34f1c9a2b7e48f4fc8d629a1f0e2dc2c3a9abc",
                  "author": {
                        "name": "Nathan Yin",
                        "email": "nathan@example.com",
                        "username": "nathanyin"
                  },
                  "committer": {
                        "name": "Nathan Yin",
                        "email": "nathan@example.com",
                        "username": "nathanyin"
                  },
                  "added": [
                        "test.sh"
                  ],
                  "removed": [],
                  "modified": [
                        "ppod.js"
                  ]
            }
      ],
      "head_commit": {
            "id": "8d34f1c9a2b7e48f4fc8d629a1f0e2dc2c3a9abc",
            "tree_id": "f6c675d9f3f884d9bdb6ef66f53f5d7400973abc",
            "distinct": true,
            "message": "Add webhook logging for push events",
            "timestamp": "2026-04-11T10:14:32Z",
            "url": "https://github.com/nathanyin/auto_deploy/commit/8d34f1c9a2b7e48f4fc8d629a1f0e2dc2c3a9abc",
            "author": {
                  "name": "Nathan Yin",
                  "email": "nathan@example.com",
                  "username": "nathanyin"
            },
            "committer": {
                  "name": "Nathan Yin",
                  "email": "nathan@example.com",
                  "username": "nathanyin"
            },
            "added": [
                  "test.sh"
            ],
            "removed": [],
            "modified": [
                  "ppod.js"
            ]
      }
}
JSON