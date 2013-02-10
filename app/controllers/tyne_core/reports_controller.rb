require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for reports
  class ReportsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json, :pjax

    before_filter :require_login
    before_filter :load_user
    before_filter :load_project
    before_filter :ensure_can_collaborate

    # Displays the list of all available reports (e.g. Issue Type Ratio)
    def index
      add_breadcrumb :index
    end
  end
end
