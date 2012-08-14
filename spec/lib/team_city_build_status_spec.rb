require 'spec_helper'

describe TeamCityBuildStatus do

  describe '.create' do

    let(:expected_payload) do
      { buildStatus: 'Running',
        buildResult: 'success',
        notifyType: 'buildFinished',
        buildRunner: 'Command Line',
        buildFullName: 'projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity',
        buildName: 'projectmonitor_ci_test_teamcity',
        buildId: '1',
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
    subject { TeamCityBuildStatus.create }

    it { should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        { buildStatus: 'Running',
          buildResult: 'failure',
          notifyType: 'buildFinished',
          buildRunner: 'Command Line',
          buildFullName: 'projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity',
          buildName: 'projectmonitor_ci_test_teamcity',
          buildId: '1',
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
      let(:status) { :failure }
      subject { TeamCityBuildStatus.create status: status}

      it { should == expected_payload }
    end

    context 'with a specified build id' do
      let(:id) { 666 }
      let(:expected_payload) do
        { buildStatus: 'Running',
          buildResult: 'success',
          notifyType: 'buildFinished',
          buildRunner: 'Command Line',
          buildFullName: 'projectmonitor_ci_test_teamcity :: projectmonitor_ci_test_teamcity',
          buildName: 'projectmonitor_ci_test_teamcity',
          buildId: id.to_s,
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
      subject { TeamCityBuildStatus.create id: id}

      it { should == expected_payload }
    end
  end
end
