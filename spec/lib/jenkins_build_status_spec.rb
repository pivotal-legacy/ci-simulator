require 'spec_helper'

describe JenkinsBuildStatus do

  describe '.create' do

    let(:expected_payload) do
      %[{"build":{"number":1,"phase":"SUCCESS"}}]
    end
    subject { JenkinsBuildStatus.create }

    it { should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        %[{"build":{"number":1,"phase":"FAILURE"}}]
      end
      let(:status) { :failure }
      subject { JenkinsBuildStatus.create status: status}

      it { should == expected_payload }
    end

    context 'with a specified build id' do
      let(:id) { 666 }
      let(:expected_payload) do
        %[{"build":{"number":666,"phase":"SUCCESS"}}]
      end
      subject { JenkinsBuildStatus.create id: id}

      it { should == expected_payload }
    end
  end
end
