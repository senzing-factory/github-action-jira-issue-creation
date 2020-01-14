# Git Action Jira Issue Creation

Git Action to create an Issue in Jira. This action can be used to create an issue when a build fails in a Git Action workflow.

## Usage

This action can be used after any other action. Below is simple example on using it:

1\. Create a `.github/workflows/git-action-jira-issue-creation.yml`

2\. Add the following properties to `git-action-jira-issue-creation.yml` file

```yaml
on: push
name: Jira Issue Creation Demo
jobs:
  jiraIssueCreation:
    name: Jira Issue Creation Demo
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Jira Creation Demo
        uses: senzing/git-action-jira-issue-creation@master
        env:
          JIRA_API_TOKEN: 'jiraApiToke'
          JIRA_USERNAME: 'user@email.com'
          JIRA_ACCOUNT_URL: 'https://someaccount.atlassian.net/'
          JIRA_PROJECT: 'jira-issue-creation'
          JIRA_ISSUE_TYPE: 'Demo''ing Jira Issue Creation'
          JIRA_ISSUE_DESCRIPTION: 'Demo''ing Jira Issue Creation'
          JIRA_ISSUE_SUMMARY: 'Demo''ing Jira Issue Creation'
```

Go [here](deployment/git-actions/template_git_action_jira_issue_creation.yml) for a template yml with all environment variables.

## Environment Variables

These are the environment variables that can be set to pass in additional information about the Git Action.

| Variable Name      | Required | Description |
|--------------------|:--------:|-------------|
| IRA_API_TOKEN | Yes | Jira API Token used instead of a password. |
| JIRA_USERNAME | Yes | Jira user email. |
| JIRA_ACCOUNT_URL | Yes | Base url to the Jira account. |
| JIRA_PROJECT | Yes | Jira project the ticket will be filed under. |
| JIRA_ISSUE_TYPE | Yes | Type of issue to be created [Bug or Task]. |
| JIRA_ISSUE_DESCRIPTION | Yes | Body of the Jira Issue. |
| JIRA_ISSUE_SUMMARY | Yes | Title of the Jira Issue. |

## Reference

* [Creating an API toke for a user.](https://confluence.atlassian.com/cloud/api-tokens-938839638.html)
* [Jira Go Lang Library](https://github.com/andygrunwald/go-jira)

## License

[Apache 2](LICENSE)
