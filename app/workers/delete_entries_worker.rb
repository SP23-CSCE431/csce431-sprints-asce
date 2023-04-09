#This worker deletes all users that were created 4 years ago to ensure that the database entries remain maintainable
class DeleteEntriesWorker
    include Sidekiq::Worker
  
    def perform
      User.where('created_at < ?', 4.years.ago).delete_all
    end
  end