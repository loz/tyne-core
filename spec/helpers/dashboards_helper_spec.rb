require 'spec_helper'

describe TyneCore::DashboardsHelper do
  before :each do
    helper.stub(:markup_to_html).and_return('')

    @user = TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")

    2.times do
      project = @user.projects.build(:name => "Foo#{rand(10**3)}", :key => "F#{rand(10**3)}", :description => 'Foo')
      project.save

      2.times do
        issue = project.issues.create(:summary => "Foo", :issue_type_id => 1)
        issue.reported_by = @user
        issue.save

        2.times do
          comment = issue.comments.build(:message => 'Foo')
          comment.user = @user
          comment.save
        end
      end
    end

    @created_projects = [@user.projects.last]
    @updated_projects = [@user.projects.first]
    @created_issues = @user.projects.last.issues
    @updated_issues = @user.projects.first.issues
    @created_comments = @user.projects.last.issues.first.comments
  end

  describe '#merge_activities' do
    it 'should order the activities correctly' do
      activities = helper.merge_activities(@created_projects, @updated_projects, @created_issues, @updated_issues, @created_comments)

      (activities.size - 1).times {|i| activities[i][0].should <= activities[i + 1][0] }
    end
  end

  describe '#user_link' do
    it 'should use user_link to create links to the users' do
      helper.should_receive(:user_link).with(@user).any_number_of_times
      activities = helper.merge_activities(@created_projects, @updated_projects, @created_issues, @updated_issues, @created_comments)
    end
  end

  describe '#project_link' do
    it 'should use project_link to create links to the projects' do
      helper.should_receive(:project_link).any_number_of_times
      activities = helper.merge_activities(@created_projects, @updated_projects, @created_issues, @updated_issues, @created_comments)
    end
  end

  describe '#issue_link' do
    it 'should use project_link to create links to the projects' do
      helper.should_receive(:issue_link).any_number_of_times
      activities = helper.merge_activities(@created_projects, @updated_projects, @created_issues, @updated_issues, @created_comments)
    end
  end
end
