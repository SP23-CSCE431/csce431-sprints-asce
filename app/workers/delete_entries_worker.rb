class DeleteEntriesWorker
    include Sidekiq::Worker
  
    def perform
      User.where('created_at < ?', 4.years.ago).delete_all
    end
  end