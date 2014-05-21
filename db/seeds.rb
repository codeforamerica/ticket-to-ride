# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#!/bin/env ruby
# encoding: utf-8

firstnames = <<-STUDENTS_FIRST
Anna Marie
Jeff
Andrew
Thom
Jeramia
Wendy
Peter
Tom
Becky
Drew
Kavi
Giselle
Tiffani
Maya
Tiffany
Jason
Lyzi
Rhys
Daniel
Clara
Danny
Andi
Sam 
David
Molly
Amy
Maksim
Erik
Ainsley
Livien
Alex
STUDENTS_FIRST


lastnames = <<-STUDENTS_LAST
Panlilio
Maher
Maier
Yin
Wilson
Whalen
Welte
Wagoner
Sperber
Schwartz
Pecherskiy
Mok
McLeod
Leonard
Kimelman
Hashemi
Harshawat
Hansen
Gonzalez-Sueyro
Getelman
Fureigh
Fong
Douglass
Diamond
Guertin
Denizac
Chu
Buckley
Boone
Benari
Bell
STUDENTS_LAST


lasid = <<-LASID
cfa2014
cfa2015
cfa2016
cfa2017
cfa2018
cfa2019
cfa2020
cfa2021
cfa2022
cfa2023
cfa2024
cfa2025
cfa2026
cfa2027
cfa2028
cfa2029
cfa2030
cfa2031
cfa2032
cfa2033
cfa2034
cfa2035
cfa2036
cfa2037
cfa2038
cfa2039
cfa2040
cfa2041
cfa2042
cfa2043
cfa2044
cfa2045
cfa2046
cfa2047
LASID

birthdays = <<-BIRTHDATE
1996-06-01
1996-03-30
1996-09-19
1996-01-08
2010-06-01
2010-03-30
2010-09-19
2010-01-08
1997-06-01
1997-03-30
1997-09-19
1997-01-08
2009-06-01
2009-03-30
2009-09-19
2009-01-08
BIRTHDATE


home_addr = <<-HOME_ADDR
250 Webster Knight Drive
1994 Dexter Street
2014 Peacedale Drive
1244 Cranston Way
345 Avenger Drive
HOME_ADDR


home_zip = <<-HOME_ZIP
02905
02840
02893 
02818
HOME_ZIP

mail_addr = <<-MAIL_ADDR
155 9th Street
156 10th Street
157 11th Street
158 12th Street
159 Franklin Ave
160 Code Street
255 9th Street
256 10th Street
257 11th Street
258 12th Street
259 Franklin Ave
260 Code Island
MAIL_ADDR


mail_zip = <<-MAIL_ZIP
94114
94112
94103
94107
94112  
MAIL_ZIP

student_firsts_seed = firstnames.each_line.to_a
student_lasts_seed = lastnames.each_line.to_a
lasid_seed = lasid.each_line.to_a
birthday_seed = birthdays.each_line.to_a
home_addr_seed = home_addr.each_line.to_a
home_zip_seed = home_zip.each_line.to_a
mail_addr_seed = mail_addr.each_line.to_a
mail_zip_seed = mail_zip.each_line.to_a

student_firsts_seed.each do |u|
  student = Student.create(
    first_name: u.strip,
    last_name: student_lasts_seed.shuffle.shift.strip,
    lasid: lasid_seed.shift.strip,
    birthday: birthday_seed.sample.strip,
    home_street_address_1: home_addr_seed.sample.strip,
    home_zip_code: home_zip_seed.sample.strip,
    mailing_street_address_1: mail_addr_seed.sample.strip,
    mailing_zip_code: mail_zip_seed.sample.strip
    )
end

# allusers = ((1..12).to_a).shuffle
# question_titles_seed.each do |qt|
#   question= Question.create(
#     content: quest_content_seed.sample.strip,
#     user_id: allusers.pop,
#     path: paths_seed.sample.strip,
#     title: qt.strip
#     )
# end

# allusers = ((1..12).to_a).shuffle
# allqs = ((1..11).to_a).shuffle
# 11.times do
#   answer = Answer.create(
#     # path: answer_urls_seed.sample.strip,
#     question_id: allqs.pop,
#     user_id: allusers.sample,
#     content: answers_content_seed.sample.strip
#     )
# end

# someqs = ((1..5).to_a).shuffle
# 5.times do
#   answer = Answer.create(
#     question_id: someqs.pop,
#     user_id: allusers.sample,
#     path: answer_urls_seed.sample.strip,
#     content: answers_content_seed.sample.strip
#     )
# end

# allusers = ((1..12).to_a).shuffle
# allas = ((1..11).to_a).shuffle
# 5.times do 
#   comment = Comment.create(
#      user_id: allusers.sample,
#      content: comment_content_seed.sample.strip,
#      commentable_type: "Answer",
#      commentable_id: allas.pop
#     )
# end


# allusers = ((1..12).to_a).shuffle
# allas = ((1..11).to_a).shuffle
# 8.times do 
#   comment = Comment.create(
#      user_id: allusers.sample,
#      content: comment_content_seed.sample.strip,
#      commentable_type: "Question",
#      commentable_id: allas.pop
#     )
# end
