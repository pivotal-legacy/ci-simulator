require 'net/http'
require File.join(File.dirname(__FILE__), 'travis_build_status.rb')

class WebhookPoster

  def self.post url, options = {}
    Net::HTTP.post_form(URI(url), payload: TravisBuildStatus.create(options))
  end

end
