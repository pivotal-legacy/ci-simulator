require 'net/http'
require File.join(File.dirname(__FILE__), 'travis_build_status.rb')
require File.join(File.dirname(__FILE__), 'jenkins_build_status.rb')

class WebhookPoster

  def self.post type, url, options = {}
    Net::HTTP.post_form(URI(url), build_status(type).create(options))
  end

  def self.build_status type
    case type.to_s
    when 'travis' then TravisBuildStatus
    when 'jenkins' then JenkinsBuildStatus
    else
      raise ArgumentError.new "Unknown build status type #{type}"
    end
  end

end
