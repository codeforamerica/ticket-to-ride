class DistrictAdminMailer < ActionMailer::Base
  default from: 'no-reply@ticket2ri.de'

  def account_created(district_admin_user, password)
    @district_admin_user = district_admin_user
    @password = password
    mail(to: @district_admin_user.email, subject: 'Welcome to Ticket to RIDE!')
  end
end
