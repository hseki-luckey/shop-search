# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

CSV.foreach('db/test.csv') do |row|
  Post.create(:shop => row[0], :area => row[1], :genre => row[2], :rate_u => row[4], :rate_l => row[3], :url => row[5])
end