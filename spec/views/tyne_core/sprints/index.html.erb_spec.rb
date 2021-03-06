require 'spec_helper'

describe "tyne_core/sprints/index.html.erb" do
  let(:user) { stub_model(TyneAuth::User, :username => "Foo") }
  let(:project) { stub_model(TyneCore::Project, :user => user, :key => "Foo") }
  let(:sprint) { stub_model(TyneCore::Sprint, :project => project) }
  let(:issue) { stub_model(TyneCore::Issue, :project => project, :issue_type_id => 1) }

  before :each do
    assign(:sprints, [sprint])
    assign(:project, project)
    assign(:issues, [issue])
    view.stub(:issue_type).and_return("Foo")
    view.stub(:issue_id).and_return("Foo")
    view.stub(:path_to_issue).and_return("Foo")
  end

  it "should render a start button" do
    render
    rendered.should have_selector(".btn")
  end

  it "should render a disabled button if any sprint is running" do
    project.stub(:any_running?).and_return(true)
    render
    rendered.should have_selector('.btn[disabled="disabled"]')
  end

  it "should render a disabled button if sprint has no issues" do
    sprint.stub_chain(:issues, :empty?).and_return(true)
    sprint.stub_chain(:issues, :count).and_return(0)
    render
    rendered.should have_selector('.btn[disabled="disabled"]')
  end
end
