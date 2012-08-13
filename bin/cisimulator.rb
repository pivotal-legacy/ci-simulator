#!/usr/bin/env ruby

require File.join(File.expand_path(File.dirname(__FILE__)), '../lib/webhook_poster.rb')

WebhookPoster.post ARGV[0]
