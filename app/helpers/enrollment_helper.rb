module EnrollmentHelper

  def does_student_have_race(student, race)
    race_downcase = race.downcase
    student.student_races.each do |student_race|
      if student_race.race.downcase == race_downcase
        return true
      end
    end

    return false
  end

end
