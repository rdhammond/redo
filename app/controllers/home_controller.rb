class HomeController < ApplicationController
  helper_method :task_types

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def task_types
    [
      ["Daily", :daily],
      ["Weekly", :weekly],
      ["Semi-Monthly", :semimonthly],
      ["Monthly", :monthly],
      ["Semi-Yearly", :semiyearly],
      ["Yearly", :yearly]
    ]
  end
end
