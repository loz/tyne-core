require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for project creation, updates, deletions
  class ProjectsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    # Renders a view to create a new project
    def new
      @project = current_user.projects.new
      respond_with(@project)
    end

    # Creates a new project.
    def create
      @project = current_user.projects.new(params[:project])
      @project.save
      respond_with(@project, :location => main_app.backlog_path(:user => current_user.username, :key => @project.key))
    end

    # Upates an existing project.
    def update
      @project = current_user.projects.find(params[:id])
      @project.update_attributes(params[:project])
      respond_with(@project, :location => main_app.admin_project_path(:user => @project.user.username, :key => @project.key))
    end

    # Destroys an existing project.
    def destroy
      @project = current_user.projects.find(params[:id])
      @project.destroy
      respond_with(@project, :location => main_app.root_path)
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
        current_user.projects.create!(:key => project.upcase, :name => project)
      end

      redirect_to tyne_core.projects_path
    end

    # Renders a view to administer a project (Edit, Delete, Teams).
    def admin
      load_project
      respond_with(@project)
    end
  end
end
