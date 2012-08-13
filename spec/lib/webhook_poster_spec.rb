require 'spec_helper'

describe WebhookPoster do

  describe '.post' do

    before do
      Net::HTTP.stub(:post_form)
    end

    context 'with a Travis project' do
      let(:type) { :travis }
      let(:url) { 'http://localhost:3000/projects/65a13435-9c40-4c60-b661-c35a17849f8e/status' }
      let(:expected_payload) do
        {payload: "{\"id\":1885641,\"number\":\"75\",\"status\":1,\"result\":0,\"status_message\":\"Broken\",\"result_message\":\"Broken\",\"started_at\":\"2012-07-17T14:16:37Z\",\"finished_at\":\"2012-07-17T14:18:52Z\",\"duration\":135,\"build_url\":\"http://www.google.com\",\"commit\":\"5bbadf792613cb64cfc67e15ae620ea3cb56b81d\",\"branch\":\"webhooks\",\"message\":\"Foo\",\"compare_url\":\"http://www.google.com\",\"committed_at\":\"2012-07-17T14:16:18Z\",\"author_name\":\"Foo Bar and Baz\",\"author_email\":\"foobar@baz.com\",\"committer_name\":\"Foo Bar and Baz\",\"committer_email\":\"foobar@baz.com\"}"}
      end
      subject { WebhookPoster.post(type, url) }

      it 'should perform a post request on the specified url and supply the json' do
        Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
        subject
      end

      context 'with a specified status' do
        let(:expected_payload) do
          {payload: "{\"id\":1885641,\"number\":\"75\",\"status\":1,\"result\":1,\"status_message\":\"Broken\",\"result_message\":\"Broken\",\"started_at\":\"2012-07-17T14:16:37Z\",\"finished_at\":\"2012-07-17T14:18:52Z\",\"duration\":135,\"build_url\":\"http://www.google.com\",\"commit\":\"5bbadf792613cb64cfc67e15ae620ea3cb56b81d\",\"branch\":\"webhooks\",\"message\":\"Foo\",\"compare_url\":\"http://www.google.com\",\"committed_at\":\"2012-07-17T14:16:18Z\",\"author_name\":\"Foo Bar and Baz\",\"author_email\":\"foobar@baz.com\",\"committer_name\":\"Foo Bar and Baz\",\"committer_email\":\"foobar@baz.com\"}"}
        end
        let(:status) { :success }
        subject { WebhookPoster.post(type, url, status: :failure) }

        it 'should supply the specified status in the json payload' do
          Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
          subject
        end
      end

      context 'with a specified build id' do
        let(:id) { 1 }
        let(:expected_payload) do
          {payload: "{\"id\":#{id},\"number\":\"75\",\"status\":1,\"result\":0,\"status_message\":\"Broken\",\"result_message\":\"Broken\",\"started_at\":\"2012-07-17T14:16:37Z\",\"finished_at\":\"2012-07-17T14:18:52Z\",\"duration\":135,\"build_url\":\"http://www.google.com\",\"commit\":\"5bbadf792613cb64cfc67e15ae620ea3cb56b81d\",\"branch\":\"webhooks\",\"message\":\"Foo\",\"compare_url\":\"http://www.google.com\",\"committed_at\":\"2012-07-17T14:16:18Z\",\"author_name\":\"Foo Bar and Baz\",\"author_email\":\"foobar@baz.com\",\"committer_name\":\"Foo Bar and Baz\",\"committer_email\":\"foobar@baz.com\"}"}
        end
        subject { WebhookPoster.post(type, url, id: id) }

        it 'should supply the specified status in the json payload' do
          Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
          subject
        end

      end
    end

    context 'with a Jenkins project' do
      let(:type) { :jenkins }
      let(:url) { 'http://localhost:3000/projects/c1fbbfc1-6fc3-4c61-8840-9be43bcefed9/status' }
      let(:expected_payload) do
        {"{\"build\":{\"number\":1,\"phase\":\"SUCCESS\"}}" => nil}
      end
      subject { WebhookPoster.post(type, url) }

      it 'should perform a post request on the specified url and supply the xml' do
        Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
        subject
      end

      context 'with a specified status' do
        let(:expected_payload) do
          {"{\"build\":{\"number\":1,\"phase\":\"FAILURE\"}}" => nil}
        end
        let(:status) { :success }
        subject { WebhookPoster.post(type, url, status: :failure) }

        it 'should supply the specified status in the json payload' do
          Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
          subject
        end
      end

      context 'with a specified build id' do
        let(:id) { 666 }
        let(:expected_payload) do
          {"{\"build\":{\"number\":666,\"phase\":\"SUCCESS\"}}" => nil}
        end
        subject { WebhookPoster.post(type, url, id: id) }

        it 'should supply the specified status in the json payload' do
          Net::HTTP.should_receive(:post_form).with(URI(url), expected_payload)
          subject
        end

      end
    end
  end

end
