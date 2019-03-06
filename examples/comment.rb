lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ig_api'
require 'pry'
account = IgApi::Account.new

user = account.login(*ARGV[0..1])
media = IgApi::Media.new(user)

response = media.create_comment(media_id: ARGV[2], comment_text: "good!")
binding.pry
