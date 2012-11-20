require 'spec_helper'

describe BacklogSidebarCell do

  context "cell instance" do
    subject { cell(:tyne_core/backlog_sidebar) }

    it { should respond_to(:filter) }
  end

  context "cell rendering" do
    context "rendering filter" do
      subject { render_cell(:tyne_core/backlog_sidebar, :filter) }

      it { should have_selector("h1", :content => "BacklogSidebar#filter") }
      it { should have_selector("p", :content => "Find me in app/cells/tyne_core/backlog_sidebar/filter.html") }
    end
  end

end
