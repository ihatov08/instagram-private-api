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
        .map{|m| m["args"]["inline_follow"] }
    end

    def to_be_follow_back_users
      started_following_you_users
        .select{|s| s["following"] == false }
        .map do |m|
          user_info = m["user_info"]
          OpenStruct.new(
            id: user_info["id"],
            username: user_info["username"],
            profile_pic_url: user_info["profile_pic_url"]
          )
      end
    end
  end
end
