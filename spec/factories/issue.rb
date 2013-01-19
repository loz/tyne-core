FactoryGirl.define do
  factory :issue, :class => "TyneCore::Issue" do
    summary "Foo"
    project
  end
end
