require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for issue creation, updates, deletions
  class IssuesController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    # Displays the index view with the default dashboard
    def index
      reflection = TyneCore::Issue.scoped
      reflection = reflection.where(params[:filter]) if params[:filter]

      @issues = reflection
    end

    # Creates a new issue
    def create
      @issue = TyneCore::Issue.new(params[:issue])
      @issue.reported_by = current_user
      @issue.save

      respond_with(@issue)
    end

    # Displays the new page for issue creation
    def new
      @issue = TyneCore::Issue.new
    end

    # Displays an existing Issue
    def show
      @issue = TyneCore::Issue.find(params[:id])
      respond_with(@issue)
    end

    # Renders a dialog partial
    def dialog
      @issue = TyneCore::Issue.new

      render 'dialog'
    end
  end
end
