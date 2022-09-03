class LunchGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user

  scope :current_month, -> { where("DATE(created_at) BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today.end_of_month) }
end
