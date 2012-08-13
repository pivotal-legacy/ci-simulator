require 'spec_helper'

describe WebhookPoster do

  describe '.post' do

    before do
      Net::HTTP.stub(:post_form)
    end

    context 'when provide with a url to post to' do
      let(:url) { 'http://localhost:3000/projects/65a13435-9c40-4c60-b661-c35a17849f8e/status' }
      let(:expected_payload) do
        {payload: "{\"id\":1885641,\"number\":\"75\",\"status\":1,\"result\":0,\"status_message\":\"Broken\",\"result_message\":\"Broken\",\"started_at\":\"2012-07-17T14:16:37Z\",\"finished_at\":\"2012-07-17T14:18:52Z\",\"duration\":135,\"build_url\":\"http://www.google.com\",\"commit\":\"5bbadf792613cb64cfc67e15ae620ea3cb56b81d\",\"branch\":\"webhooks\",\"message\":\"Foo\",\"compare_url\":\"http://www.google.com\",\"committed_at\":\"2012-07-17T14:16:18Z\",\"author_name\":\"Foo Bar and Baz\",\"author_email\":\"foobar@baz.com\",\"committer_name\":\"Foo Bar and Baz\",\"committer_email\":\"foobar@baz.com\"}"}
      end
      subject { WebhookPoster.post(url) }

      it 'should perform a post request on the specified url and supply the json' do
        Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
        subject
      end

      context 'and a status' do
        let(:expected_payload) do
          {payload: "{\"id\":1885641,\"number\":\"75\",\"status\":1,\"result\":1,\"status_message\":\"Broken\",\"result_message\":\"Broken\",\"started_at\":\"2012-07-17T14:16:37Z\",\"finished_at\":\"2012-07-17T14:18:52Z\",\"duration\":135,\"build_url\":\"http://www.google.com\",\"commit\":\"5bbadf792613cb64cfc67e15ae620ea3cb56b81d\",\"branch\":\"webhooks\",\"message\":\"Foo\",\"compare_url\":\"http://www.google.com\",\"committed_at\":\"2012-07-17T14:16:18Z\",\"author_name\":\"Foo Bar and Baz\",\"author_email\":\"foobar@baz.com\",\"committer_name\":\"Foo Bar and Baz\",\"committer_email\":\"foobar@baz.com\"}"}
        end
        let(:status) { :success }
        subject { WebhookPoster.post(url, status: :failure) }

        it 'should supply the specified status in the json payload' do
          Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
          subject
        end
      end
    end
  end

end
