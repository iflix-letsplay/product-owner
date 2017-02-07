# product-owner

A set of scripts to extract information from GitHub and JIRA that POs care about, without wasting dev time.

## `todays-prs.rb`

Get a list of the PRs that got closed today, and email it to the POs (_this last part is still TODO_)

```
PO_TOKEN=... bundle exec ruby todays-prs.rb
```
