require 'spec_helper'

describe TravisBuildStatus do

  describe '.create' do

    let(:expected_payload) do
      {payload: %[{"id":1,"number":"75","status":1,"result":0,"status_message":"Broken","result_message":"Broken","started_at":"2012-07-17T14:16:37Z","finished_at":"2012-07-17T14:18:52Z","duration":135,"build_url":"http://www.google.com","commit":"5bbadf792613cb64cfc67e15ae620ea3cb56b81d","branch":"webhooks","message":"Foo","compare_url":"http://www.google.com","committed_at":"2012-07-17T14:16:18Z","author_name":"Foo Bar and Baz","author_email":"foobar@baz.com","committer_name":"Foo Bar and Baz","committer_email":"foobar@baz.com"}] }.to_query
    end
    subject { TravisBuildStatus.create }

    it { should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        {payload: %[{"id":1,"number":"75","status":1,"result":1,"status_message":"Broken","result_message":"Broken","started_at":"2012-07-17T14:16:37Z","finished_at":"2012-07-17T14:18:52Z","duration":135,"build_url":"http://www.google.com","commit":"5bbadf792613cb64cfc67e15ae620ea3cb56b81d","branch":"webhooks","message":"Foo","compare_url":"http://www.google.com","committed_at":"2012-07-17T14:16:18Z","author_name":"Foo Bar and Baz","author_email":"foobar@baz.com","committer_name":"Foo Bar and Baz","committer_email":"foobar@baz.com"}] }.to_query
      end
      let(:status) { :failure }
      subject { TravisBuildStatus.create status: status}

      it { should == expected_payload }
    end

    context 'with a specified build id' do
      let(:id) { 666 }
      let(:expected_payload) do
        {payload: %[{"id":#{id},"number":"75","status":1,"result":0,"status_message":"Broken","result_message":"Broken","started_at":"2012-07-17T14:16:37Z","finished_at":"2012-07-17T14:18:52Z","duration":135,"build_url":"http://www.google.com","commit":"5bbadf792613cb64cfc67e15ae620ea3cb56b81d","branch":"webhooks","message":"Foo","compare_url":"http://www.google.com","committed_at":"2012-07-17T14:16:18Z","author_name":"Foo Bar and Baz","author_email":"foobar@baz.com","committer_name":"Foo Bar and Baz","committer_email":"foobar@baz.com"}] }.to_query
      end
      subject { TravisBuildStatus.create id: id}

      it { should == expected_payload }
    end
  end
end
