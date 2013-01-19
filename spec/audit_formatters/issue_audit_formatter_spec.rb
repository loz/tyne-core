require 'spec_helper'

describe TyneCore::IssueAuditFormatter do
  before :each do
    Rails.application.config.stub(:assets_dir).and_return('/')
  end

  it "should format an issue audit" do
    issue = create(:issue, :summary => "baz")
    audit = issue.audits.first
    audit.stub(:user).and_return(issue.project.user)

    audit.formatted.should_not be_empty
    audit.details.should == "baz"
    audit.icon.should =~ /img/
  end

  it "should format an issue audit for update" do
    issue = create(:issue)
    audit = issue.audits.first
    audit.stub(:user).and_return(issue.project.user)
    audit.stub(:action).and_return(:update)

    audit.formatted.should_not be_empty
    audit.icon.should =~ /img/
  end
end
