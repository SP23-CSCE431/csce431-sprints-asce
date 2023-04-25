# This worker resets the points attribute of every user to 0
class ResetUserPointsWorker
  include Sidekiq::Worker

  def perform
    User.update_all(points: 0)
  end
end
