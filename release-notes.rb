require 'octokit'

usage = <<USAGE
\n\nUsage:
\tPO_TOKEN=1234 ruby release-notes.rb release_number'
USAGE

release = ARGV[0]

raise usage if release.nil?
raise usage if ENV['PO_TOKEN'].nil?

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
  # closed as many in a signle release iteration
  per_page: 200
}

pull_requests = client.pull_requests(repo, options)

# Filter PRs based on their milestone
this_version_prs = pull_requests.select do |pr|
  next if pr.milestone.nil?
  pr.milestone.title == release
end
  .map do |pr|
  jira_id_regex = /\w+-\d+/
  jira_id = nil
  if pr.title =~ jira_id_regex
    jira_id = pr.title.match(jira_id_regex)
  end

  {
    url: pr.html_url,
    title: pr.title,
    jira_id: jira_id
  }
end
  .sort_by { |pr| pr[:title] }

=begin
# Interpolate the PR data into HTML messages
messages = this_version_prs.map do |pr|
  msg = "<a href=\"#{pr[:url]}\">#{pr[:title]}</a>"

  if pr[:jira_id]
    msg += " (JIRA Ticket: <a href=\"#{jira_base_url}/#{pr[:jira_id]}\">#{pr[:jira_id]}</a>)"
  end

  msg
end

output = "<h2>Full Release Notes for Version #{release}</h2>"
output += "<ul>" + messages.map { |msg| "<li>#{msg}</li>" }.join("\n") + "</ul>"
=end

messages = this_version_prs.map do |pr|
  msg = "[#{pr[:title]}](#{pr[:url]})"
  msg += " (JIRA Ticket: [#{pr[:jira_id]}](#{jira_base_url}/#{pr[:jira_id]}))" if pr[:jira_id]
  msg
end

puts <<OUT
## Full Release Notes for Version #{release}

#{messages.map { |m| "- #{m}" }.join("\n")}
OUT

# TODO: use the appropraite email API to send the output via email
