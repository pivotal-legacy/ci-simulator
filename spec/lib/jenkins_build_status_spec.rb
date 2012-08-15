require 'spec_helper'

describe JenkinsBuildStatus do

  describe '.create' do
    let(:expected_payload) do
      %[{"build":{"number":1,"phase":"SUCCESS"}}]
    end

    it { JenkinsBuildStatus.create.should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        %[{"build":{"number":1,"phase":"FAILURE"}}]
      end

      it { JenkinsBuildStatus.create(status: :failure).should == expected_payload }
    end

    context 'with a specified build id' do
      let(:expected_payload) do
        %[{"build":{"number":666,"phase":"SUCCESS"}}]
      end

      it { JenkinsBuildStatus.create(id: 666).should == expected_payload }
    end
  end
end
