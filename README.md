# product-owner

A set of scripts to extract information from GitHub and JIRA that POs care about, without wasting dev time.

# `todays-prs.rb`

Get a list of the PRs that got closed today, and email it to the POs (_this last part is still TODO_)

```
PO_TOKEN=... bundle exec ruby todays-prs.rb
```


# `release-pdf.sh`

## pre-steps
get ruby, node and other dependencies
```sh
curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable --ruby
rvm install "ruby-2.6.5"
rvm use 2.6.5
gem install bundler

#install node https://nodejs.org/en/download
sudo npm install mdpdf -g
sudo npm install -g phantomjs-prebuilt --unsafe-perm=true  --allow-root

chmod +x  release-pdf.sh
```

## usage 
PO_TOKEN is Github API key

PO_TOKEN=<private po token> ./release-pdf.sh <release version> <pdf name> 

eg. ```PO_TOKEN=abc123 ./release-pdf.sh "2.42.0" "iOS-2.42.0--RC-1--BUILD-15065--Release-Notes"``` 

the pdf name contains the release version, candidate version and build version
