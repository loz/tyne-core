require 'spec_helper'

describe TyneCore::IssuesHelper do
  let(:user) { TyneAuth::User.new(:name => "Foo", :username => "Foo") }
  let(:issue) { TyneCore::Issue.new }

  describe :issue_type do
    it "should render a tag with the name of the reporter" do
      issue.stub_chain(:issue_type, :name).and_return("Bug")

      content = helper.issue_type(issue)
      content.should have_selector "span.tag"
      content.should have_content "Bug"
    end
  end

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

  describe :default_action do
    it "should return a link with the correct transition" do
      issue.stub_chain(:project, :user).and_return(user)
      issue.stub_chain(:project, :key).and_return("Foo")
      issue.stub(:id).and_return(1337)
      issue.stub(:state).and_return("open")

      helper.default_action(issue).should have_selector("a")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.start_working"))

      issue.stub(:state).and_return("reopened")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.start_working"))

      issue.stub(:state).and_return("wip")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.task_is_done"))

      issue.stub(:state).and_return("done")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.reopen"))

      issue.stub(:state).and_return("invalid")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.reopen"))
    end
  end
end
