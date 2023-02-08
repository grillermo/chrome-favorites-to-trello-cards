require 'trello'
require 'nokogiri'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY'] # The "key" from step 1
  config.member_token = ENV['TRELLO_MEMBER_TOKEN'] # The token from step 2.
  config.http_client = 'rest-client'
end

# Takes links the way chrome exports and returns
# [
#   {title: 'parsed html <title/>', url: 'http...'
# ]
def parse_links(chrome_exported_favorites)
  # bookmarks_7_1_15.html is from a Google Chrome Bookmark export
  nodes = Nokogiri::HTML File.open(chrome_exported_favorites, "r").read

  bookmarks = nodes.css("a")

  arr = []

  bookmarks.each do |bookmark|
    hash = {
      title: bookmark.text,
      url: bookmark.attr("href"),
    }
    
    arr << hash
  end

  arr
end

def add_card(link)
  truncated_link = link[0..10].gsub(/\s\w+\s*$/, '...')

  puts "Creating card for #{truncated_link}"
  Trello::Card.create(
    name: link[:title],
    desc: link[:url],
    pos: :bottom,
    idList: ENV['JOBS_LIST_ID']
  )
end

def add_all_cards
  chrome_exported_favorites = ENV['CHROME_BOOKMARKS_FILE']
  links = parse_links(chrome_exported_favorites)

  links.map(&method(:add_card))
end

def delete_cards_in_list
  Trello::List.find(ENV['JOBS_LIST_ID']).cards.each do |card|
    card.delete
  end
end
# delete_cards_in_list

add_all_cards
