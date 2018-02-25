class Task < ApplicationRecord
  enum task_type: [ :daily, :weekly, :semi_monthly, :monthly, :semi_yearly, :yearly ]

  validates :description, presence: true
  validates :task_type, presence: true

	def done?
		not self.next_refresh.nil? and Date.today < self.next_refresh
	end

	def complete
		today = Date.today
		next_refresh = today + task_duration

		if self.semi_monthly? and today.month === next_refresh.month
			next_refresh = today.next_month.at_beginning_of_month
		end

		self.last_completed = today
		self.next_refresh = next_refresh
	end

	def reset
		self.last_completed = nil
		self.next_refresh = nil
	end

	private

	def task_duration
		case self.task_type
		when "daily"
			1.day
		when "weekly"
			1.week
		when "semi_monthly"
			2.weeks
		when "monthly"
			1.month
		when "semi_yearly"
			6.months
		when "yearly"
			1.year
		end
	end
end
