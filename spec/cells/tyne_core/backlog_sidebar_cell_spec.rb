require 'spec_helper'

describe TyneCore::BacklogSidebarCell do
  subject { cell(:"tyne_core/backlog_sidebar") }

  describe :filter do
    it "should render the view" do
      subject.should_receive(:render)
      subject.filter
    end
  end

  describe :sorting do
    it "should render the view" do
      subject.should_receive(:render)
      subject.sorting
    end
  end

  describe :grouping do
    it "should render the view" do
      subject.should_receive(:render)
      subject.grouping
    end
  end
end
