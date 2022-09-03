class User < ApplicationRecord
  rolify
  has_one_attached :file
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :employees, -> { with_role(:employee) }

  belongs_to :department, optional: true
  has_many :lunch_groups

  def admin?
    has_role? :admin
  end

  def employee?
    has_role? :employee
  end

  def manage_mystery_group
    MysteryLunch::Create.new(self, true).call
  end
end
