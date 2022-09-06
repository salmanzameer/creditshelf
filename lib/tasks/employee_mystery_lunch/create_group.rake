namespace :employee_mystery_lunch do
  namespace :create_group do
    task create_mystery_group: :environment do
       MysteryLunch::Manage.new.call
    end
  end
end
