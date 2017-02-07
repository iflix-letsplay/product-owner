require 'octokit'

# TODO: make these values configurable via ARGV or something
repo = 'iflix-letsplay/apple-ios'
jira_base_url = 'https://teamiflix.atlassian.net/browse'

# Init an Octokit client with a token with access to the repo you want to
# inspect
client = Octokit::Client.new(:access_token => ENV['PO_TOKEN'])

options = {
  # We're after the PRs that made into trunk, so only get the closed ones
  state: 'closed',
  # It would be better to properly handle pagination, but as a lazy first step
  # we can just ask for a big number of PR and hope that the dev team hasn't
  # closed as many in one single day
  per_page: 100
}

pull_requests = client.pull_requests(repo, options)

# Filter today's PRs based on the closed date
today = Time.now
todays_prs = pull_requests.select do |pr|
  pr.closed_at.year == today.year &&
    pr.closed_at.month == today.month &&
    pr.closed_at.day == today.day
end

# Interpolate the PR data into HTML messages
messages = todays_prs.map do |pr|
  msg = "<a href=\"#{pr.html_url}\">#{pr.title}</a>"

  jira_id_regex = /\w+-\d+/
  if pr.title =~ jira_id_regex
    ticket_id = pr.title.match(jira_id_regex)
    msg += " (JIRA Ticket: <a href=\"#{jira_base_url}/#{ticket_id}\">#{ticket_id}</a>)"
  end

  msg
end

output = "<ul>" + messages.each { |msg| puts "<li>#{msg}</li>" } + "</ul>"

puts output

# TODO: use the appropraite email API to send the output via email
