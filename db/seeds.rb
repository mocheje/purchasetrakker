# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles = Role.create([{ name: 'Requester' }, { name: 'Receiver' }, { name: 'Approver'}, { name: 'Stockkepper' }, {name: 'Issuer'}, {name: 'Admin'}])
Station.new({name: "default", location: "lagos"}).save(:validate => false)
Department.new({name: "default", station_id: 1}).save(:validate => false)
User.new({email: "ptrakk@default.com", password: "passw0rd", password_confirmation: "passw0rd", department_id: 1, first_name: "login", last_name: "demo" }).save(:validate => false)
RolesUsers.create({role_id: 6, user_id:1})