require 'active_support/core_ext/object/to_query'

class TeamCityBuildStatus

  def self.create options = {}
    options = {
      id: 1,
      status: :success
    }.merge(options)

    { buildStatus: 'Running',
      buildResult: convert_status(options[:status]),
      notifyType: 'buildFinished',
      buildRunner: 'Command Line',
      buildFullName: 'projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity',
      buildName: 'projectmonitor_ci_test_teamcity',
      buildId: options[:id].to_s,
      buildTypeId: 'bt2',
      projectName: 'projectmonitor_ci_test_teamcity',
      projectId: 'project2',
      buildNumber: '13',
      agentName: 'Default Agent',
      agentOs: 'Linux, version 2.6.18-xenU-ec2-v1.5',
      agentHostname: 'localhost',
      triggeredBy: 'ci',
      message: "Build projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished.  This is build number 13, has a status of 'Running' and was triggered by ci",
      text: 'projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished. Status: Running'
    }.to_query('build')
  end

  def self.convert_status status
    case status.to_s
    when 'success', '0'
      'success'
    else
      'failure'
    end
  end

end
