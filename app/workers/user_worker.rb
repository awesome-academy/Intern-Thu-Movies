class UserWorker
  include Sidekiq::Worker

  def perform movie_id
    UserMailer.send_mail_lock_movie movie_id
  end
end
