require 'spec_helper'

describe SemaphoreBuildStatus do

  describe '.create' do
    let(:expected_payload) do
      %[{"branch_name":"gem_updates","branch_url":"https://semaphoreapp.com/projects/44/branches/50","project_name":"base-app","build_url":"https://semaphoreapp.com/projects/44/branches/50/builds/15","build_number":1,"result":"passed","started_at":"2012-07-09T15:23:53Z","finished_at":"2012-07-09T15:30:16Z","commit":{"id":"dc395381e650f3bac18457909880829fc20e34ba","url":"https://github.com/renderedtext/base-app/commit/dc395381e650f3bac18457909880829fc20e34ba","author_name":"Vladimir Saric","author_email":"vladimir@renderedtext.com","message":"Update 'shoulda' gem.","timestamp":"2012-07-04T18:14:08Z"}}]
    end

    it { SemaphoreBuildStatus.create.should == expected_payload }

    context 'with a specified status' do
      let(:expected_payload) do
        %[{"branch_name":"gem_updates","branch_url":"https://semaphoreapp.com/projects/44/branches/50","project_name":"base-app","build_url":"https://semaphoreapp.com/projects/44/branches/50/builds/15","build_number":1,"result":"failed","started_at":"2012-07-09T15:23:53Z","finished_at":"2012-07-09T15:30:16Z","commit":{"id":"dc395381e650f3bac18457909880829fc20e34ba","url":"https://github.com/renderedtext/base-app/commit/dc395381e650f3bac18457909880829fc20e34ba","author_name":"Vladimir Saric","author_email":"vladimir@renderedtext.com","message":"Update 'shoulda' gem.","timestamp":"2012-07-04T18:14:08Z"}}]
      end

      it { SemaphoreBuildStatus.create(status: :failure).should == expected_payload }
    end

    context 'with a specified build id' do
      let(:expected_payload) do
        %[{"branch_name":"gem_updates","branch_url":"https://semaphoreapp.com/projects/44/branches/50","project_name":"base-app","build_url":"https://semaphoreapp.com/projects/44/branches/50/builds/15","build_number":666,"result":"passed","started_at":"2012-07-09T15:23:53Z","finished_at":"2012-07-09T15:30:16Z","commit":{"id":"dc395381e650f3bac18457909880829fc20e34ba","url":"https://github.com/renderedtext/base-app/commit/dc395381e650f3bac18457909880829fc20e34ba","author_name":"Vladimir Saric","author_email":"vladimir@renderedtext.com","message":"Update 'shoulda' gem.","timestamp":"2012-07-04T18:14:08Z"}}]
      end

      it { SemaphoreBuildStatus.create(id: 666).should == expected_payload }
    end
  end

end
