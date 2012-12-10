require 'spec_helper'

describe TyneCore::Project do
  it { should have_many :teams }

  it "should have an owner and a contributor team" do
    user = stub_model(TyneAuth::User)
    project = user.projects.create!(:key => "FOO", :name => "Foo")
    teams = project.teams
    owners = teams.detect { |x| x.name == "Owners" && x.admin_privileges }
    owner = owners.members.detect { |x| x.user_id == user.id }
    owner.should be_present

    contributors = teams.detect { |x| x.name == "Contributors" }
    contributors.should be_present
  end
end
