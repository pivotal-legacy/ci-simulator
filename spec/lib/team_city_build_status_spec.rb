require 'spec_helper'

describe TeamCityBuildStatus do

  describe '.create' do
    let(:expected_payload) do
      'build%5BagentHostname%5D=localhost&build%5BagentName%5D=Default+Agent&build%5BagentOs%5D=Linux%2C+version+2.6.18-xenU-ec2-v1.5&build%5BbuildFullName%5D=projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity&build%5BbuildId%5D=1&build%5BbuildName%5D=projectmonitor_ci_test_teamcity&build%5BbuildNumber%5D=13&build%5BbuildResult%5D=success&build%5BbuildRunner%5D=Command+Line&build%5BbuildStatus%5D=Running&build%5BbuildTypeId%5D=bt2&build%5Bmessage%5D=Build+projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity+has+finished.++This+is+build+number+13%2C+has+a+status+of+%27Running%27+and+was+triggered+by+ci&build%5BnotifyType%5D=buildFinished&build%5BprojectId%5D=project2&build%5BprojectName%5D=projectmonitor_ci_test_teamcity&build%5Btext%5D=projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity+has+finished.+Status%3A+Running&build%5BtriggeredBy%5D=ci'
    end

    it { TeamCityBuildStatus.create.should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        'build%5BagentHostname%5D=localhost&build%5BagentName%5D=Default+Agent&build%5BagentOs%5D=Linux%2C+version+2.6.18-xenU-ec2-v1.5&build%5BbuildFullName%5D=projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity&build%5BbuildId%5D=1&build%5BbuildName%5D=projectmonitor_ci_test_teamcity&build%5BbuildNumber%5D=13&build%5BbuildResult%5D=failure&build%5BbuildRunner%5D=Command+Line&build%5BbuildStatus%5D=Running&build%5BbuildTypeId%5D=bt2&build%5Bmessage%5D=Build+projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity+has+finished.++This+is+build+number+13%2C+has+a+status+of+%27Running%27+and+was+triggered+by+ci&build%5BnotifyType%5D=buildFinished&build%5BprojectId%5D=project2&build%5BprojectName%5D=projectmonitor_ci_test_teamcity&build%5Btext%5D=projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity+has+finished.+Status%3A+Running&build%5BtriggeredBy%5D=ci'
      end

      it { TeamCityBuildStatus.create(status: :failure).should == expected_payload }
    end

    context 'with a specified build id' do
      let(:expected_payload) do
        'build%5BagentHostname%5D=localhost&build%5BagentName%5D=Default+Agent&build%5BagentOs%5D=Linux%2C+version+2.6.18-xenU-ec2-v1.5&build%5BbuildFullName%5D=projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity&build%5BbuildId%5D=666&build%5BbuildName%5D=projectmonitor_ci_test_teamcity&build%5BbuildNumber%5D=13&build%5BbuildResult%5D=success&build%5BbuildRunner%5D=Command+Line&build%5BbuildStatus%5D=Running&build%5BbuildTypeId%5D=bt2&build%5Bmessage%5D=Build+projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity+has+finished.++This+is+build+number+13%2C+has+a+status+of+%27Running%27+and+was+triggered+by+ci&build%5BnotifyType%5D=buildFinished&build%5BprojectId%5D=project2&build%5BprojectName%5D=projectmonitor_ci_test_teamcity&build%5Btext%5D=projectmonitor_ci_test_teamcity+%3A%3A+projectmonitor_ci_test_teamcity+has+finished.+Status%3A+Running&build%5BtriggeredBy%5D=ci'
      end

      it { TeamCityBuildStatus.create(id: 666).should == expected_payload }
    end
  end
end
