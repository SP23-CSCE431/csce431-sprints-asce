class DashboardsController < ApplicationController
  layout 'dashboard'
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = Event.all
    @events_by_date = @events.group_by { |event| event.start.to_date }
  end
end
