require 'spec_helper'

describe TyneCore::Issue do
  let(:user) { TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo") }
  let(:project) { user.projects.create!(:key => "Foo", :name => "Foo") }
  let(:issue) { project.issues.create!(:summary => "Foo", :issue_type_id => 1) }

  describe :available_transitions do
    context "for a new ticket" do
      it "should return the current state without an action" do
        described_class.new.available_transitions.should == { "open" => nil }
      end
    end

    context "for an existing ticket" do
      before :each do
        issue.stub(:new_record?).and_return(false)
      end

      it "should return the current state and the available states" do
        issue.available_transitions.should == { "open" => nil, "wip" => :start_working, "done" => :task_is_done, "invalid" => :task_is_invalid }
      end
    end
  end

  describe :states do
    it "should be completed if state is done" do
      issue.should_not be_completed

      issue.start_working
      issue.should_not be_completed

      issue.task_is_done
      issue.should be_completed

      issue.task_is_done
      issue.should be_completed

      issue.reopen
      issue.should_not be_completed
    end

    it "should be completed if state is invalid" do
      issue.task_is_invalid
      issue.completed?.should be_true
    end
  end

  describe :number do
    it "should use the next available number in the project context" do
      max = (project.issues.maximum('number') || 0)
      issue = project.issues.create!(:summary => "Foo", :issue_type_id => 1)
      issue.number.should == max + 1
    end
  end
end
