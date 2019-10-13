#!/bin/sh
# Inspired by : https://github.com/maxheld83/ghpages/blob/822ef8d4db40e9bd1cebcaabf2a98856372db959/entrypoint.sh

set -e

if [ -n "$INPUT_DIR" ]; then
    echo "#################################################"
    echo "Changing directory to 'DIR' $INPUT_DIR ..."
    cd $INPUT_DIR
fi

if [ -z "$INPUT_TARGET_BRANCH" ]; then
    INPUT_TARGET_BRANCH="gh-pages"
fi

## Setup
REMOTE_REPO="https://${INPUT_GH_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
REPONAME="$(echo $GITHUB_REPOSITORY| cut -d'/' -f 2)"
OWNER="$(echo $GITHUB_REPOSITORY| cut -d'/' -f 1)"
GHIO="${OWNER}.github.io"

if [[ "$REPONAME" == "$GHIO" && "$INPUT_TARGET_BRANCH" == "gh-pages" ]]; then
  target_branch="master"
else
  target_branch="gh-pages"
fi

echo "#################################################"
echo "Now deploying to ${INPUT_TARGET_BRANCH}"
## fqdn validation
REGEX='^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.){2,}([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]){2,}$'
if [ -n "$INPUT_FQDN" ]; then
    if echo "$INPUT_FQDN" | grep -Eq $REGEX; then
        echo "Target fqdn: ${INPUT_FQDN}"
        echo $INPUT_FQDN > CNAME
        echo "On ${INPUT_FQDN}"
    else
        echo "${INPUT_FQDN} is not a valid domain name. Exiting"
        exit 1
    fi
fi

ls
## Deployment
rm -rf .git
git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -m "Deploy to ${INPUT_TARGET_BRANCH}"
git push --force $REMOTE_REPO master:$INPUT_TARGET_BRANCH > /dev/null 2>&1
rm -fr .git
echo "Content of $INPUT_DIR has been deployed to ${INPUT_TARGET_BRANCH}."
