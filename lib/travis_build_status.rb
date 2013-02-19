require 'json'

class TravisBuildStatus

  def self.create options = {}
    options = {
      id: 1,
      status: :success
    }.merge(options)

    { payload:
      { id: options[:id],
        number: '75',
        status: 1,
        state: "building",
        branch: "master",
        result: convert_status(options[:status]),
        status_message: 'Broken',
        result_message: 'Broken',
        started_at: '2013-07-17T14:16:37Z',
        finished_at: '2013-07-17T14:18:52Z',
        duration: 135,
        build_url: 'http://www.google.com',
        commit: '5bbadf792613cb64cfc67e15ae620ea3cb56b81d',
        message: 'Foo',
        compare_url: 'http://www.google.com',
        committed_at: '2013-07-17T14:16:18Z',
        author_name: 'Foo Bar and Baz',
        author_email: 'foobar@baz.com',
        committer_name: 'Foo Bar and Baz',
        committer_email: 'foobar@baz.com'
      }.to_json
    }.to_query
  end

private

  def self.convert_status status
    if status == :success
      0
    else
      1
    end
  end

end
