class Task < ApplicationRecord
  validates :description, presence: true
  validates :task_type, presence: true
  validates :done, inclusion: {in: [true, false]}

  enum task_type: [ :daily, :weekly, :semi_monthly, :monthly, :semi_yearly, :yearly ]
end
