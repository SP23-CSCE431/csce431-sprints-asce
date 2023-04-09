every 1.day, at: '12:00am' do
    runner 'DeleteEntriesWorker.perform_async'
end

every '0 0 1 1,5 *' do
    runner 'ResetUserPointsWorker.perform_async'
end