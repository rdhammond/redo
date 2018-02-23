class Task < ApplicationRecord
  enum task_types: [ :daily, :weekly, :semimonthly, :monthly, :semiyearly, :yearly ]
  validates :description, presence: true
  validates :task_types, presence: true
  validates :done, presence: true
end
