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
rvm install "ruby-2.3.1"
rvm use 2.3.1
gem install bundler

#install node https://nodejs.org/en/download
sudo npm install mdpdf -g
sudo npm install -g phantomjs-prebuilt --unsafe-perm=true  --allow-root

chmod +x  release-pdf.sh
```

## usage 

PO_TOKEN=<private po token> ./release-pdf.sh <i||a> <release version> 

eg. ```PO_TOKEN=abc123 ./release-pdf.sh i 2.42.0``` 

the first arg must be "i" for iOS or "a" for Android
