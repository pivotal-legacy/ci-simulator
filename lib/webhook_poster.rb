require 'net/http'

class WebhookPoster

  TRAVIS_PAYLOAD = <<-EOJSON
{
   "id":1885645,
   "number":"75",
   "status":1,
   "result":1,
   "status_message":"Broken",
   "result_message":"Broken",
   "started_at":"2012-07-17T14:16:37Z",
   "finished_at":"2012-07-17T14:18:52Z",
   "duration":135,
   "build_url":"http://www.google.com",
   "commit":"5bbadf792613cb64cfc67e15ae620ea3cb56b81d",
   "branch":"webhooks",
   "message":"Foo",
   "compare_url":"http://www.google.com",
   "committed_at":"2012-07-17T14:16:18Z",
   "author_name":"Foo Bar and Baz",
   "author_email":"foobar@baz.com",
   "committer_name":"Foo Bar and Baz",
   "committer_email":"foobar@baz.com"
}
  EOJSON

  def self.post url
    Net::HTTP.post_form(URI(url), payload: TRAVIS_PAYLOAD)
    true
  end

end
