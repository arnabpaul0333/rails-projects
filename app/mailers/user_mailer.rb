class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    attachments['download.jpg'] = File.read('/home/kreetiuser/Desktop/download.jpg')
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
end

