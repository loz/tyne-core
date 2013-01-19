FactoryGirl.define do
  factory :user, :class => "TyneAuth::User" do
    name "Test"
    username "test"
    uid 123456
    token "foo"
    gravatar_id "foo"
  end
end
