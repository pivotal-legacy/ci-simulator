require 'spec_helper'

describe TeamCityBuildStatus do

  describe '.create' do
    let(:expected_payload) do
      "{\"build\":{\"buildStatus\":\"Running\",\"buildResult\":\"success\",\"notifyType\":\"buildFinished\",\"buildRunner\":\"Command Line\",\"buildFullName\":\"projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity\",\"buildName\":\"projectmonitor_ci_test_teamcity\",\"buildId\":\"1\",\"buildTypeId\":\"bt2\",\"projectName\":\"projectmonitor_ci_test_teamcity\",\"projectId\":\"project2\",\"buildNumber\":\"13\",\"agentName\":\"Default Agent\",\"agentOs\":\"Linux, version 2.6.18-xenU-ec2-v1.5\",\"agentHostname\":\"localhost\",\"triggeredBy\":\"ci\",\"message\":\"Build projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished.  This is build number 13, has a status of 'Running' and was triggered by ci\",\"text\":\"projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished. Status: Running\"}}"
    end

    it { TeamCityBuildStatus.create.should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        "{\"build\":{\"buildStatus\":\"Running\",\"buildResult\":\"failure\",\"notifyType\":\"buildFinished\",\"buildRunner\":\"Command Line\",\"buildFullName\":\"projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity\",\"buildName\":\"projectmonitor_ci_test_teamcity\",\"buildId\":\"1\",\"buildTypeId\":\"bt2\",\"projectName\":\"projectmonitor_ci_test_teamcity\",\"projectId\":\"project2\",\"buildNumber\":\"13\",\"agentName\":\"Default Agent\",\"agentOs\":\"Linux, version 2.6.18-xenU-ec2-v1.5\",\"agentHostname\":\"localhost\",\"triggeredBy\":\"ci\",\"message\":\"Build projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished.  This is build number 13, has a status of 'Running' and was triggered by ci\",\"text\":\"projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished. Status: Running\"}}"
      end

      it { TeamCityBuildStatus.create(status: :failure).should == expected_payload }
    end

    context 'with a specified build id' do
      let(:expected_payload) do
        "{\"build\":{\"buildStatus\":\"Running\",\"buildResult\":\"success\",\"notifyType\":\"buildFinished\",\"buildRunner\":\"Command Line\",\"buildFullName\":\"projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity\",\"buildName\":\"projectmonitor_ci_test_teamcity\",\"buildId\":\"666\",\"buildTypeId\":\"bt2\",\"projectName\":\"projectmonitor_ci_test_teamcity\",\"projectId\":\"project2\",\"buildNumber\":\"13\",\"agentName\":\"Default Agent\",\"agentOs\":\"Linux, version 2.6.18-xenU-ec2-v1.5\",\"agentHostname\":\"localhost\",\"triggeredBy\":\"ci\",\"message\":\"Build projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished.  This is build number 13, has a status of 'Running' and was triggered by ci\",\"text\":\"projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity has finished. Status: Running\"}}"
      end

      it { TeamCityBuildStatus.create(id: 666).should == expected_payload }
    end
  end
end
