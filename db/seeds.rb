# This file should contain all the record creation needed to seed the database with its default values.
#
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
  {
    email: 'rmeyer@halbrek.com',
    password: ENV['rmeyer_password']
  },{
    email: 'plotwatt@halbrek.com',
    password: ENV['plotwatt_password']

  }
]

# Base seed of users
users.each{|user|  User.create(user) }
