class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def genderPronounToEnum(pronoun)
    pronoun_uppercase =  pronoun.upcase

    if pronoun_uppercase == 'HE'
      return :male
    else 
      return :female
    end
    #TODO: Raise exception if unknown detected
  end

  def genderEnumToPronoun(gender_enum)

    if gender_enum == :male
      return 'he'
    else 
      return 'she'
    end
  end
    #TODO: Raise exception if unknown detected

  def genderEnumToPossessivePronoun(gender_enum)
    if gender_enum == :male
      return 'his'
    else 
      return 'her'
    end
  end
    #TODO: Raise exception if unknown detected

  def genderEnumToPossessiveAdjective(gender_enum)
    if gender_enum == :male
      return 'his'
    else 
      return 'her'
    end
  end
    #TODO: Raise exception if unknown detected

  def genderEnumToObjectivePronoun(gender_enum)
    if gender_enum == :male
      return 'him'
    else
      return 'her'
    end
    #TODO: Raise exception if unknown detected
  end

  def isIsntToBoolean(isOrIsnt)
    if isOrIsnt.upcase == 'IS'
      return true
    end
    #TODO: Raise exception if unknown detected

    return false
  end
end
