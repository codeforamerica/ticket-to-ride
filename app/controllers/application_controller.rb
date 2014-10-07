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

  def genderToPronoun(gender)

    if gender == nil
      return '(unknown gender)'
    end #TODO: Raise exception if unknown detected

    if gender == :male || gender.downcase == 'male'
      return 'he'
    else
      return 'she'
    end
  end


  def genderToPossessivePronoun(gender)
    if gender == nil
      return '(unknown gender)'
    end #TODO: Raise exception if unknown detected

    if gender == :male || gender.downcase == 'male'
      return 'his'
    else
      return 'her'
    end
  end
  #TODO: Raise exception if unknown detected

  def genderToPossessiveAdjective(gender)
    if gender == nil
      return '(unknown gender)'
    end #TODO: Raise exception if unknown detected

    if gender == :male || gender.downcase == 'male'
      return 'his'
    else
      return 'her'
    end
  end
  #TODO: Raise exception if unknown detected

  def genderToObjectivePronoun(gender)
    if gender == nil
      return '(unknown gender)'
    end #TODO: Raise exception if unknown  detected

    if gender == :male || gender.downcase == 'male'
      return 'him'
    else
      return 'her'
    end
    #TODO: Raise exception if unknown detected
  end

  def isIsntToBoolean(is_or_isnt)
    if is_or_isnt == nil
      return "(unknown is/isn't)"
    end #TODO: Raise exception if unknown detected

    if is_or_isnt.downcase == 'is'
      return true
    end
    #TODO: Raise exception if unknown detected

    return false
  end

  def are_admins?
    return AdminUser.any?
  end

  def are_central_admins?
    return AdminUser.where(user_role: :central_admin).any?
  end

  def are_district_admins?
    return AdminUser.where(user_role: :district_admin).any?
  end

  def district_names
    district_names = []
    District.all.each do |district|
      district_names << district.name.capitalize
    end

    return district_names
  end

end
