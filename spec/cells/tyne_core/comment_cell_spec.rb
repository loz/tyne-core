require 'spec_helper'

describe CommentCell do

  context "cell instance" do
    subject { cell(:tyne_core/comment) }

    it { should respond_to(:form) }
    it { should respond_to(:list) }
  end

  context "cell rendering" do
    context "rendering form" do
      subject { render_cell(:tyne_core/comment, :form) }

      it { should have_selector("h1", :content => "Comment#form") }
      it { should have_selector("p", :content => "Find me in app/cells/tyne_core/comment/form.html") }
    end

    context "rendering list" do
      subject { render_cell(:tyne_core/comment, :list) }

      it { should have_selector("h1", :content => "Comment#list") }
      it { should have_selector("p", :content => "Find me in app/cells/tyne_core/comment/list.html") }
    end
  end

end
