# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM golang:1.13.4-alpine3.10 as BUILD

ARG GO_BUILD_FILES=git-action-jira-issue-creation

# Add github
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        git \
        make

# Copy repo
COPY ${GO_BUILD_FILES} /go/src/${GO_BUILD_FILES}

WORKDIR /go/src/${GO_BUILD_FILES}

# Building go app
RUN make build

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
