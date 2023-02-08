Convert chrome bookmarks export to trello cards

Instructions

1. Clone this repo
2. `bundle install`
3. add .env file replacing the values for your own
```bash
export TRELLO_MEMBER_TOKEN=
export TRELLO_DEVELOPER_PUBLIC_KEY=
export JOBS_LIST_ID=
export CHROME_BOOKMARKS_FILE=yourbookmarks.html
# See ruby-trello readme for instructions on how to get th token and key https://github.com/jeremytregunna/ruby-trello
```
4. source .env and then run the ruby file
`$source .env
ruby app.rb
`

