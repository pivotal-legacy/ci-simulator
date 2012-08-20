#!/usr/bin/env ruby

require 'sinatra'
require 'haml'
require File.join(File.expand_path(File.dirname(__FILE__)), '../lib/webhook_poster.rb')

def valid_url(url)
  url =~ %r{\Ahttps?://} && URI(url)
rescue URI::InvalidURIError
end

get '/' do
  haml :index, locals: {:id => 1, url: nil, type: 'travis', status: 'success', error_message: nil}
end

post '/' do

  error_message =
    if params[:build_id] !~ /\A\d+\Z/
      "Build id should be an integer"
    elsif !valid_url(params[:url])
      "URL should be a valid http(s) webhook URI from project monitor"
    end

  build_id = params[:build_id].to_i

  unless error_message
    begin
      WebhookPoster.post params[:type].to_sym, params[:url], status: params[:status].to_sym, id: build_id
    rescue => e
      error_message = e.message
    end
  end

  haml :index, locals: {:id => build_id + 1, url: params[:url], type: params[:type], status: params[:status], error_message: error_message}
end

__END__
@@ index
!!!
%html{xmlns: 'http://www.w3.org/1999/xhtml' }
  %head
    %title Project Monitor Simulator
    :css
      .label {
        width: 200px;
        font-weight: bold;
        float: left;
      }

      fieldset .select, fieldset .input {
        float: left;
      }

      input[type=submit] {
        width: 150px;
      }

      input[name=url] {
        width: 250px;
      }

      .errors {
        border: 1px solid red;
        padding: 14px;
        display: inline-block;
        background: #faa;
        margin-bottom: 14px;
      }
  %body
    %h1 Project Monitor Simulator

    - if error_message
      .errors= error_message

    %form{method: 'post', action: '/'}
      %fieldset
        %div
          .label Project monitor URL
          %input{name: 'url', value: url}
        %div
          .label CI server type
          %select{name: 'type'}
            %option{value: 'travis', selected: (type == 'travis')} Travis
            %option{value: 'jenkins', selected: (type == 'jenkins')} Jenkins
            %option{value: 'teamcity', selected: (type == 'teamcity')} TeamCity
            %option{value: 'semaphore', selected: (type == 'semaphore')} Semaphore
        %div
          .label Build status
          %select{name: 'status'}
            %option{value: 'success', selected: (status == 'success')} Success
            %option{value: 'failure', selected: (status == 'failure')} Failure
        %div
          .label Build ID
          %input{name: 'build_id', value: id}
        %div
          %input{type: 'submit', value: 'Post'}
