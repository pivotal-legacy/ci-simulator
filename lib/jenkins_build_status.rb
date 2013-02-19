class JenkinsBuildStatus

  def self.create options = {}
    options = {
      id: 1,
      status: :success
    }.merge(options)

    {
      build: {
         number: options[:id],
         status: convert_status(options[:status]),
         url: 'foo'
      }
    }.to_json
  end

private

  def self.convert_status status
    if status == :success
      'SUCCESS'
    else
      'FAILURE'
    end
  end

end
