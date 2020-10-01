class UserMailer < ApplicationMailer
   def welcome_send(user)
    @user = user
    mail to: user.email, subject: 'Welcome to My Awesome Site', from: 'berlinarchnet@gmail.com'
  end
end
