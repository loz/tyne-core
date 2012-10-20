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

    def github
      github = current_user.github_client
      @repositories = github.repositories
    end

    def import
      projects = params[:name]
      projects.each do |project|
        TyneCore::Project.create(:key => project.upcase, :name => project)
      end

      redirect_to :action => :index
    end
  end
end
