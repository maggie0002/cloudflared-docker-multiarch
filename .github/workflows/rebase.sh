#!/usr/bin/env bash
set -e

# Fetch the latest commits from CloudFlareD repository
git remote add upstream https://github.com/cloudflare/cloudflared.git
git fetch --tags upstream

# Rebase the current branch
git rebase upstream/master

# Get the latest tag by date
latest_tag=$(git describe --tags --abbrev=0)
echo "Latest tag: $latest_tag"

# Check to see if there is a new tag from CloudFlare
if [[ ${latest_tag:(-3)} != "-ma" ]]
then
    # Add a new tag for the multi-arch images to trigger a build
    git tag $latest_tag-ma
fi

# Push any changes
git push origin master --tags
