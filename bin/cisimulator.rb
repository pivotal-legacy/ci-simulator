#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'
require File.join(File.expand_path(File.dirname(__FILE__)), '../lib/webhook_poster.rb')

options = OpenStruct.new
options.webhook_endpoint = nil
options.build_status_options = {}

optparse = OptionParser.new do |optparse|
  optparse.on('-d', '--type <TYPE>', 'Type of payload to deliver, one of (travis|jenkins)') do |type|
    options.type = type
  end

  optparse.on('-e', '--endpoint <URL>', 'Webhook endpoint (URL)') do |url|
    options.webhook_endpoint = url
  end

  optparse.on('-s', '--status <STATUS>', 'Status for build, one of (failure|success)') do |status|
    options.build_status_options[:status] = status
  end

  optparse.on('-i', '--id <ID>', 'Build status id') do |id|
    options.build_status_options[:id] = id
  end

  optparse.on_tail('-h', '--help', 'Show this message') do
    puts optparse
    exit
  end

  optparse.parse!(ARGV)
  optparse
end

if options.webhook_endpoint.nil?
  puts optparse
  exit
end

WebhookPoster.post options.type, options.webhook_endpoint, options.build_status_options
