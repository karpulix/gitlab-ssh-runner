#!/bin/sh
docker build -t karpulix/gitlab_ssh_run:latest .
docker tag karpulix/gitlab_ssh_run:latest  karpulix/gitlab_ssh_run:latest
docker push karpulix/gitlab_ssh_run:latest
