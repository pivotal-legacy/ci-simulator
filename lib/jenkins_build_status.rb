class JenkinsBuildStatus

  def self.create options = {}
    options = {
      id: 1885641,
      status: :success
    }.merge(options)

    {
      {
        build: {
           number: 1,
           phase: 'SUCCESS',
        }
      }.to_json => nil
    }
  end

end
