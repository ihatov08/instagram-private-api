lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ig_api'
require 'pry'
account = IgApi::Account.new

user = account.login(*ARGV)
binding.pry
search = user.search_for_user 'instagram' #search

news = user.news
started_following_you_users = news.started_following_you_users
puts started_following_you_users

puts
