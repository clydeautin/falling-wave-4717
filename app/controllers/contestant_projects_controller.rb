class ContestantProjectsController < ApplicationController
  
  def create
    @contestant = Contestant.find(params[:contestant_id])
    @project = Project.find(params[:id])
    ContestantProject.create(contestant: @contestant, project: @project)
    redirect_to "/projects/#{params[:id]}"
  end
end