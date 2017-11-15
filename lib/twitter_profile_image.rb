require "twitter_profile_image/version"
require "twitter_profile_image/configuration"
require "twitter_api"
require "json"

module TwitterProfileImage
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= TwitterProfileImage::Configuration.new
    end

    def get(screen_name, variant='original')
      api = Api.new(
        {
          consumer_key: @configuration.consumer_key,
          consumer_secret: @configuration.consumer_secret,
          token: @configuration.token,
          token_secret: @configuration.token_secret
        })
      user = api.get_users_show(screen_name)
      url = user['profile_image_url_https']
      profile_image_url_replace_by_variant(url, variant)
    end

    def profile_image_url_replace_by_variant(url, variant)
      original_url = url.gsub(/_(normal|bigger|mini)\.(png|jpe?g)/, '.\2')
      case variant
      when 'normal'
        original_url.gsub(/\.(png|jpe?g)/, '_normal.\1')
      when 'bigger'
        original_url.gsub(/\.(png|jpe?g)/, '_bigger.\1')
      when 'mini'
        original_url.gsub(/\.(png|jpe?g)/, '_mini.\1')
      when 'original'
        original_url
      else
        original_url.gsub(/\.(png|jpe?g)/, '_normal.\1')
      end
    end
  end

  class Api
    def initialize(credentials)
      @t = TwitterAPI::Client.new(credentials)
    end

    def get_users_show(screen_name)
      res = @t.get('https://api.twitter.com/1.1/users/show.json', {
                     'screen_name': screen_name
                   })
      JSON.parse(res.body)
    end
  end
end
