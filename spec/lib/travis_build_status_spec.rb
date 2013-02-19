require 'spec_helper'

describe TravisBuildStatus do

  describe '.create' do

    let(:expected_payload) do
      'payload=%7B%22id%22%3A1%2C%22number%22%3A%2275%22%2C%22status%22%3A1%2C%22state%22%3A%22building%22%2C%22branch%22%3A%22master%22%2C%22result%22%3A0%2C%22status_message%22%3A%22Broken%22%2C%22result_message%22%3A%22Broken%22%2C%22started_at%22%3A%222013-07-17T14%3A16%3A37Z%22%2C%22finished_at%22%3A%222013-07-17T14%3A18%3A52Z%22%2C%22duration%22%3A135%2C%22build_url%22%3A%22http%3A%2F%2Fwww.google.com%22%2C%22commit%22%3A%225bbadf792613cb64cfc67e15ae620ea3cb56b81d%22%2C%22message%22%3A%22Foo%22%2C%22compare_url%22%3A%22http%3A%2F%2Fwww.google.com%22%2C%22committed_at%22%3A%222013-07-17T14%3A16%3A18Z%22%2C%22author_name%22%3A%22Foo+Bar+and+Baz%22%2C%22author_email%22%3A%22foobar%40baz.com%22%2C%22committer_name%22%3A%22Foo+Bar+and+Baz%22%2C%22committer_email%22%3A%22foobar%40baz.com%22%7D'
    end

    it { TravisBuildStatus.create.should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        'payload=%7B%22id%22%3A1%2C%22number%22%3A%2275%22%2C%22status%22%3A1%2C%22state%22%3A%22building%22%2C%22branch%22%3A%22master%22%2C%22result%22%3A1%2C%22status_message%22%3A%22Broken%22%2C%22result_message%22%3A%22Broken%22%2C%22started_at%22%3A%222013-07-17T14%3A16%3A37Z%22%2C%22finished_at%22%3A%222013-07-17T14%3A18%3A52Z%22%2C%22duration%22%3A135%2C%22build_url%22%3A%22http%3A%2F%2Fwww.google.com%22%2C%22commit%22%3A%225bbadf792613cb64cfc67e15ae620ea3cb56b81d%22%2C%22message%22%3A%22Foo%22%2C%22compare_url%22%3A%22http%3A%2F%2Fwww.google.com%22%2C%22committed_at%22%3A%222013-07-17T14%3A16%3A18Z%22%2C%22author_name%22%3A%22Foo+Bar+and+Baz%22%2C%22author_email%22%3A%22foobar%40baz.com%22%2C%22committer_name%22%3A%22Foo+Bar+and+Baz%22%2C%22committer_email%22%3A%22foobar%40baz.com%22%7D'
      end

      it { TravisBuildStatus.create(status: :failure).should == expected_payload }
    end

    context 'with a specified build id' do
      let(:expected_payload) do
        'payload=%7B%22id%22%3A666%2C%22number%22%3A%2275%22%2C%22status%22%3A1%2C%22state%22%3A%22building%22%2C%22branch%22%3A%22master%22%2C%22result%22%3A0%2C%22status_message%22%3A%22Broken%22%2C%22result_message%22%3A%22Broken%22%2C%22started_at%22%3A%222013-07-17T14%3A16%3A37Z%22%2C%22finished_at%22%3A%222013-07-17T14%3A18%3A52Z%22%2C%22duration%22%3A135%2C%22build_url%22%3A%22http%3A%2F%2Fwww.google.com%22%2C%22commit%22%3A%225bbadf792613cb64cfc67e15ae620ea3cb56b81d%22%2C%22message%22%3A%22Foo%22%2C%22compare_url%22%3A%22http%3A%2F%2Fwww.google.com%22%2C%22committed_at%22%3A%222013-07-17T14%3A16%3A18Z%22%2C%22author_name%22%3A%22Foo+Bar+and+Baz%22%2C%22author_email%22%3A%22foobar%40baz.com%22%2C%22committer_name%22%3A%22Foo+Bar+and+Baz%22%2C%22committer_email%22%3A%22foobar%40baz.com%22%7D'
      end

      it { TravisBuildStatus.create(id: 666).should == expected_payload }
    end
  end
end
