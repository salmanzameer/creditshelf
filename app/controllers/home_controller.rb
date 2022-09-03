class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.includes(lunch_groups: :user).where("DATE(created_at) BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today.end_of_month)
  end
end