# -----------------------------------------------------------------------------
# Stage: build
# -----------------------------------------------------------------------------
FROM golang:1.25.5-alpine3.21@sha256:b4dbd292a0852331c89dfd64e84d16811f3e3aae4c73c13d026c4d200715aff6 AS build

ARG GITHUB_HEAD_REF="main"
ARG GITHUB_EVENT_NAME="push"

# Add github
RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  git \
  make

WORKDIR /go/src

HEALTHCHECK CMD git --version || exit 1

# Clone repo
RUN git clone https://github.com/senzing-factory/github-action-jira-issue-creation.git

WORKDIR /go/src/github-action-jira-issue-creation

# Check merge if build is triggered by a pull request
RUN git checkout ${GITHUB_HEAD_REF}; \
  if [[ "${GITHUB_HEAD_REF}" != "main" && ${GITHUB_EVENT_NAME} == "pull_request" ]]; then \
  git merge main; \
  fi

# Building go app
RUN make build

# -----------------------------------------------------------------------------
# Stage: build
# -----------------------------------------------------------------------------
FROM alpine:3.23@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62

LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="purple"
LABEL "com.github.actions.name"="GitHub Action Jira Issue Creation"
LABEL "com.github.actions.description"="Create a Jira Issue"

COPY --from=build /go/bin/github-action-jira-issue-creation /usr/bin
COPY --from=build /go/src/github-action-jira-issue-creation/LICENSE /
COPY --from=build /go/src/github-action-jira-issue-creation/README.md /

RUN mkdir -p /github/workspace

USER 1001

WORKDIR /github/workspace

ENTRYPOINT ["github-action-jira-issue-creation"]
