require 'spec_helper'

describe TyneCore::ApplicationHelper do
  describe :markup_to_html do
    it "should convert markdown into html" do
      markdown = <<EOS
* Foo
* Bar
* Baz
EOS
      content = helper.markup_to_html(markdown)
      content.should have_selector("li", :count => 3)
    end
  end
end
