every 1.day, at: '12:00am' do
    runner 'DeleteEntriesWorker.perform_async'
  end