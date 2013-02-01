require 'spec_helper'

describe "tyne_core/sprints/current.html.erb" do
  let(:user) { stub_model(TyneAuth::User, :username => "Foo") }
  let(:project) { stub_model(TyneCore::Project, :user => user, :key => "Foo") }
  let(:sprint) { stub_model(TyneCore::Sprint, :project => project) }

  before :each do
    assign(:sprint, sprint)

    render
  end

  it "should render a progress bar" do
    rendered.should have_selector(".progress")
  end
end
