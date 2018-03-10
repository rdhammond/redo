class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @task = Task.new
    @tasks = Task.all
  end
end
