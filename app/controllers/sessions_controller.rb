class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github_service = GithubService.new
    session[:token] = github_service.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])
    session[:username] = github_service.get_username
    @user = session[:username]
    redirect_to root_path
  end
end
