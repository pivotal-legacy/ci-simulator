class JenkinsBuildStatus

  def self.create options = {}
    options = {
      id: 1,
      status: :success
    }.merge(options)

    {
      build: {
         number: options[:id],
         phase: convert_status(options[:status]),
      }
    }.to_json
  end

private

  def self.convert_status status
    case status.to_s
    when 'success', '0'
      'SUCCESS'
    else
      'FAILURE'
    end
  end

end
