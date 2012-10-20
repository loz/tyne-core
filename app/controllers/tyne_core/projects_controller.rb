require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests to project creation, updates, deletions
  class ProjectsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    # Displays a list of all projects
    def index
      @projects = TyneCore::Project.all
      @project = TyneCore::Project.new
      respond_with(@projects)
    end

    # Creates a new project.
    def create
      @project = TyneCore::Project.new(params[:project])
      @project.save
      respond_with(@project) do |format|
        format.html { render @project }
      end
    end

    # Upates an existing project.
    def update
      @project = TyneCore::Project.find(params[:id])
      @project.update_attributes(params[:project])
      respond_with(@project) do |format|
        format.html { render @project }
      end
    end

    # Destroys an existing project.
    def destroy
      @project = TyneCore::Project.find(params[:id])
      @project.destroy
      render :json => { :ok => true }
    end

    # Displays the list of all available github projects.
    def github
      github = current_user.github_client
      @repositories = github.repositories
    end

    # Imports the selected github repos.
    def import
      projects = params[:name]
      projects.each do |project|
        TyneCore::Project.create(:key => project.upcase, :name => project)
      end

      redirect_to :action => :index
    end
  end
end
