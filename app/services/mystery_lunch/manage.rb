module MysteryLunch
  class Manage
    def call
      process
    end
     
    def employees
      @employees ||= User.employees
    end 

    def create_mystery_lunch
      employees.each_with_index do |user, i|
        last_user = employees.count == (i + 1)
        Create.new(user, last_user).call
      end
    end

    def process
      create_mystery_lunch
    end
  end
end
