# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM golang:1.13.4-alpine3.10 as BUILD

ARG GITHUB_HEAD_REF="master"
ARG GITHUB_EVENT_NAME="push"

# Add github
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        git \
        make

WORKDIR /go/src

# Clone repo
RUN git clone https://github.com/senzing/git-action-jira-issue-creation.git

WORKDIR /go/src/git-action-jira-issue-creation

# Check merge if build is triggered by a pull request
WORKDIR /go/src/git-action-jira-issue-creation
RUN if [[ "${GITHUB_HEAD_REF}" != "master" && "${GITHUB_EVENT_NAME}" == "pull_request" ]]; then \
        git checkout ${GITHUB_HEAD_REF}; \
        git merge master; \
    fi

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

RUN mkdir -p /github/workspace

WORKDIR /github/workspace

ENTRYPOINT ["git-action-jira-issue-creation"]
