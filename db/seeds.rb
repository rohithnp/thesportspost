# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.create(:email => 'admin@test.com', :password => 'asdfasdf', :password_confirmation => 'asdfasdf')
u.roles_mask = 1
u.save

User.create(:email => 'noob@test.com', :password => 'asdfasdf', :password_confirmation => 'asdfasdf')

u = User.create(:email => 'editor@test.com', :password => 'asdfasdf', :password_confirmation => 'asdfasdf')
u.roles_mask = 4
u.save

u = User.create(:email => 'writer@test.com', :password => 'asdfasdf', :password_confirmation => 'asdfasdf')
u.roles_mask = 2
u.save


Category.create(:full_name => 'MMA', :name => 'mma')
Category.create(:full_name => 'Basketball', :name => 'basketball')
Category.create(:full_name => 'Football', :name => 'football')
Category.create(:full_name => 'Baseball', :name => 'baseball')


