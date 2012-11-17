require 'spec_helper'

describe TyneCore::IssuesHelper do
  let(:user) { TyneAuth::User.new(:name => "Foo") }
  let(:issue) { TyneCore::Issue.new }

  describe :issue_reported_by do
    it "should render a tag with the name of the reporter" do
      issue.stub(:reported_by).and_return(user)

      content = helper.issue_reported_by(issue)
      content.should have_selector "span.tag"
      content.should have_content user.name
    end
  end

  describe :issue_reported_at do
    it "should render a tag with the date of creation" do
      date = 3.days.ago
      issue.stub(:created_at).and_return(date)

      content = helper.issue_reported_at(issue)
      content.should have_selector "span.tag"
      content.should have_content date.to_date.to_s

      issue.stub(:created_at).and_return(Date.today)
      content = helper.issue_reported_at(issue)
      content.should have_content "Today"
    end
  end

  describe :issue_id do
    it "should return a combined string of the project key and the issue id" do
      issue.stub_chain(:project, :key).and_return("TYNE")
      issue.stub(:id).and_return(1337)

      helper.issue_id(issue).should == "TYNE-1337"
    end
  end
end
