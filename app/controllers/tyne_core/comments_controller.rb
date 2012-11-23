module TyneCore
  class CommentsController < TyneCore::ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_user
    before_filter :load_project

    def create
      @issue = @project.issues.find_by_number(params[:issue_id])
      @comment = @issue.comments.build(params[:comment]) do |c|
        c.user = current_user
      end
      @comment.save
      respond_with(@comment) do |format|
        format.pjax { render @comment }
      end
    end

    def update

    end

    def destroy

    end
  end
end
