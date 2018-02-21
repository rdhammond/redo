class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :task_types

  def task_types
    [
      "Daily",
      "Weekly",
      "Semi-Monthly",
      "Montly",
      "Semi-Yearly",
      "Yearly"
    ]
  end
end
