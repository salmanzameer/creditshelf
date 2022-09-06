module MysteryLunch
  class Create
    attr_accessor :user, :new_or_deleted_user
    def initialize(user, new_or_deleted_user)
      @user = user
      @new_or_deleted_user = new_or_deleted_user
    end

    def call
      process
    end

    private
    
    def new_group
      Group.create
    end

    def skip_groups
      LunchGroup.current_month.where(user_id: not_group_users_ids).pluck(:group_id)
    end

    def available_group
      Group.joins('left join lunch_groups on groups.id = lunch_groups.group_id')
           .where("DATE(groups.created_at) BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today.end_of_month)
           .where.not(id: skip_groups)
           .group('groups.id')
           
    end

    def group_to_join
      available_group.having("count(groups.id) < 3 ").first
    end

    def group
      group_to_join.present? ? group_to_join : new_group
    end

    def create_mystery_lunch
      group.lunch_groups.create(user_id: user.id)
    end

    def group_ids
      LunchGroup.where(user_id: user.id)
                .where("DATE(created_at) BETWEEN ? AND ?", (Date.today.beginning_of_month - 3.months), (Date.today.beginning_of_month - 1.day))
                .pluck(:group_id)
    end

    def same_dep_employee
      User.where.not(id: user.id).where(department_id: user.department_id).pluck(:id)
    end

    def not_group_users_ids
      same_dep_employee + same_group_users_ids
    end

    def same_group_users_ids
      LunchGroup.joins(:user)
                .where.not(user_id: user.id)
                .where(group_id: group_ids)
                .pluck(:user_id)
    end

    def process
      create_mystery_lunch
    end
  end
end
