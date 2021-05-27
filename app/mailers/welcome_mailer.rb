class WelcomeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.send_when_signup.subject
  #
  def send_when_signup(email, name)
    # viewファイル上に、userの登録氏名（name）を表示するために定義したインスタンス変数
    @name = name
    # subjectには任意の件名が指定できる
    mail to: email, subject: "【Bookers】Registration Conplete! Thanks for Joining!"
  end
end
