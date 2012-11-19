TyneCore::IssueType.delete_all
%w(Bug Enhancement Story Feature Task).each do |issue_type|
  TyneCore::IssueType.create!(:name => issue_type)
end
