require 'net/http'
require File.join(File.dirname(__FILE__), 'travis_build_status.rb')
require File.join(File.dirname(__FILE__), 'jenkins_build_status.rb')
require File.join(File.dirname(__FILE__), 'team_city_build_status.rb')

class WebhookPoster

  def self.post type, url, options = {}
    uri = URI(url)

    req = Net::HTTP::Post.new(uri.path)
    req.body = build_status(type).create(options)

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end

private

  def self.build_status type
    case type
    when :travis then TravisBuildStatus
    when :jenkins then JenkinsBuildStatus
    when :teamcity then TeamCityBuildStatus
    else
      raise ArgumentError.new "Unknown build status type #{type}"
    end
  end

end
