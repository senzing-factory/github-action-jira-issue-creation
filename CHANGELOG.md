# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2020-02-23

### Added to 1.1.0

- Ability to attach files to the Jira Issue
- Docker file to include the default Git Actions workspace so it can be leveraged to interact with the runner's workspace during a CI/CD pipeline.

## [1.0.0] - 2020-01-11

### Added to 1.0.0

- Docker file to build the image used by Git Actions.
- Added standard documentation artifacts and license.
- Go Lang app that pushes a message to slack.
- Git Actions CI pipeline to test the docker build and go app build on commits.
- Git Actions CD pipeline triggered on pull request to verify the merged changes does not break master.
