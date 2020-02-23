# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM golang:1.13.4-alpine3.10 as BUILD

# Add github
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        git \
        make

# Copy repo
COPY . /go/src/git-action-jira-issue-creation

WORKDIR /go/src/git-action-jira-issue-creation

# Building go app
RUN ls -lart

# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM alpine:3.10

LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="purple"
LABEL "com.github.actions.name"="Git Action Jira Issue Creation"
LABEL "com.github.actions.description"="Create a Jira Issue"

COPY --from=BUILD /go/bin/git-action-jira-issue-creation /usr/bin
COPY --from=BUILD /go/src/git-action-jira-issue-creation/LICENSE /
COPY --from=BUILD /go/src/git-action-jira-issue-creation/README.md /

RUN mkdir -p /github

WORKDIR /github

ENTRYPOINT ["git-action-jira-issue-creation"]
