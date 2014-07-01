class Student < ActiveRecord::Base
  has_many :guardians
  has_many :student_races
  belongs_to :school
  acts_as_birthday :birthday
  enum gender: [:male, :female]
  enum grade: [:pre_kindergarten, :kindergarten, :grade_1, :grade_2, :grade_3, :grade_4, :grade_5, :grade_6, :grade_7, :grade_8, :grade_9, :grade_10, :grade_11, :grade_12]
end