class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def genderPronounToEnum(pronoun)
    pronoun_uppercase =  pronoun.upcase

    if pronoun_uppercase == 'HE'
      return :male
    end
    #TODO: Raise exception if unknown detected

    return :female
  end

  def genderEnumToPronoun(gender_enum)

    if gender_enum == :male
      return 'he'
    end
    #TODO: Raise exception if unknown detected

    return 'she'
  end

  def genderEnumToPossessivePronoun(gender_enum)
    if gender_enum == :male
      return 'his'
    end
    #TODO: Raise exception if unknown detected

    return 'hers'
  end

  def genderEnumToObjectivePronoun(gender_enum)
    if gender_enum == :male
      return 'him'
    end
    #TODO: Raise exception if unknown detected

    return 'her'
  end

  def isIsntToBoolean(isOrIsnt)
    if isOrIsnt.upcase == 'IS'
      return true
    end
    #TODO: Raise exception if unknown detected

    return false
  end
end
