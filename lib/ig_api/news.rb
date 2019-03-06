require 'ostruct'

module IgApi
  class News
    TYPES = {
      follow: 3,
      like: 1,
      comment: 14
    }

    def initialize
      @api = Http.singleton
    end

    def using user
      @user = {
        id: user.data[:id],
        session: user.session,
        ua: user.useragent
      }
      self
    end

    def inbox
      endpoint = "#{Constants::URL}news/inbox/"
      result = @api.get(endpoint)
                 .with(session: @user[:session], ua: @user[:ua]).exec

      JSON.parse result.body
    end

    def started_following_you_users
      inbox["old_stories"]
        .select{|s| s["type"] == TYPES[:follow] }
        .map{|m| m["args"]["inline_follow"]["user_info"] }
    end
  end
end
