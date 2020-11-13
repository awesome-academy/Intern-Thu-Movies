class UserMailer < ApplicationMailer
  def self.send_mail_lock_movie movie_id
    emails_admin = User.admin.pluck :email
    movie = Movie.unscoped.find movie_id

    emails_admin.each do |email|
      send_mail(email, movie).deliver_now
    end
  end

  def send_mail email, movie
    @movie = movie
    mail to: email, subject: t(".notification")
  end
end
