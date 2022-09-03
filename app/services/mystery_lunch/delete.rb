module MysteryLunch
  class Delete
    attr_accessor :user
    def initialize(user)
      @user = user
    end

    def call
      process
    end

    def lunch_group
      @lunch_group ||= LunchGroup.current_month.where(user_id: user.id).first
    end

    def group_full?
      group.lunch_groups.count > 2
    end

    def group
      @group ||= lunch_group.group
    end

    def alone_member
      group.lunch_groups.where.not(user_id: user.id).first.user
    end

    def assign_member
      group.delete
      Create.new(alone_member, true).call
    end

    def delete_user
      lunch_group.delete
      user.delete
    end
    
    def process
      delete_user
      assign_member unless group_full?
    end
  end
end
