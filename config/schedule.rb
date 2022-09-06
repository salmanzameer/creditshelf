every 1.month, at: '02:00', roles: [:job] do
  rake "employee_mystery_lunch:create_group:create_mystery_group"
end
