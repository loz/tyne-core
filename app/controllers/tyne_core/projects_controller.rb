require_dependency "tyne_core/application_controller"

module TyneCore
  class ProjectsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    def index
      @projects = TyneCore::Project.all
      @project = Project.new
      respond_with(@projects)
    end

    def create
      @project = Project.new(params[:project])
      @project.save
      respond_with(@project) do |format|
        format.html { render @project }
      end
    end

    def update
      @project = Project.find(params[:id])
      @project.update_attributes(params[:project])
      respond_with(@project) do |format|
        format.html { render @project }
      end
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      render :json => { :ok => true }
    end
  end
end
