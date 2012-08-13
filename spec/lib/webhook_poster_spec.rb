require 'spec_helper'

describe WebhookPoster do

  describe '.post' do

    before do
      Net::HTTP.stub(:post_form)
    end

    context 'when provide with a url to post to' do
      let(:url) { URI('http://localhost:3000/projects/65a13435-9c40-4c60-b661-c35a17849f8e/status') }
      let(:expected_payload) { {payload: WebhookPoster::TRAVIS_PAYLOAD} }
      subject { WebhookPoster.post(url) }

      it 'should perform a post request on the specified url and supply the json' do
        Net::HTTP.should_receive(:post_form).with(url, expected_payload)
        subject
      end

      it { should be_true }
    end

  end

end
