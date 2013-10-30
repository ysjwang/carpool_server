# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  FactoryGirl::create(:user_with_contacts)
end

User.create(first_name: 'Test User First', last_name: 'Test User Last', email: 'devise_test_user@email.com', password: 'password', password_confirmation: 'password')