require 'spec_helper'

describe WebhookPoster do

  shared_examples_for 'a webhook poster' do
    it 'passes the hostname and port to HTTP.start' do
      Net::HTTP.should_receive(:start).with('localhost', 3000)
      subject
    end

    it 'should save the build status payload as the request body' do
      payload = double(:payload)
      build_status_class.stub(:create).and_return(payload)

      request = double(:request)
      Net::HTTP::Post.stub(:new).and_return(request)
      request.should_receive(:body=).with(payload)
      subject
    end

    it 'should post the request' do
      http = double(:http)
      http.should_receive(:request)
      Net::HTTP.stub(:start).and_yield(http)
      subject
    end

    it 'should create the appropriate payload' do
      build_status_class.should_receive(:create)
      subject
    end
  end

  describe '.post' do

    let(:request) { double(:request) }

    before do
      request.stub(:body=)
      Net::HTTP::Post.stub(:new).and_return(request)
      Net::HTTP.stub(:start)
    end


    let(:url) { 'http://localhost:3000/projects/65a13435-9c40-4c60-b661-c35a17849f8e/status' }
    subject { WebhookPoster.post(type, url) }

    context 'with a url that has no path' do
      let(:url) { 'http://localhost:3000' }

      subject { WebhookPoster.post(:travis, url) }

      it 'should post with the root path' do
        Net::HTTP::Post.should_receive(:new).with('/')
        subject
      end
    end

    context 'with a Travis project' do
      let(:type) { :travis }
      let(:build_status_class) { TravisBuildStatus }

      it_should_behave_like 'a webhook poster'
    end

    context 'with a Jenkins project' do
      let(:type) { :jenkins }
      let(:build_status_class) { JenkinsBuildStatus }

      it_should_behave_like 'a webhook poster'
    end

    context 'with a TeamCity project' do
      let(:type) { :teamcity }
      let(:build_status_class) { TeamCityBuildStatus }

      it_should_behave_like 'a webhook poster'
    end

    context 'with a Semaphore project' do
      let(:type) { :semaphore }
      let(:build_status_class) { SemaphoreBuildStatus }

      it_should_behave_like 'a webhook poster'
    end

    context 'with an unknown project' do
      let(:type) { :wibble }

      it 'should create a team city payload' do
        expect do
          subject
        end.to raise_error(ArgumentError)
      end
    end
  end

end
