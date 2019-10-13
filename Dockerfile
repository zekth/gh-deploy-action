FROM alpine/git:latest

LABEL "name"="deploy-action"
LABEL "maintainer"="Vincent Le Goff <vince.legoff@gmail.com>"
LABEL "repository"="http://github.com/zekth/gh-deploy"
LABEL "homepage"="http://github.com/zekth/gh-deploy"

LABEL "com.github.actions.name"="GitHub Branch Deploy"
LABEL "com.github.actions.description"="Deploy anything to Github branches"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
