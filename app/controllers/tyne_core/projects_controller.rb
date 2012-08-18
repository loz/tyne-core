require_dependency "tyne_core/application_controller"

module TyneCore
  class ProjectsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    def index
      @projects = TyneCore::Project.all
      respond_with(@projects)
    end
  end
end
