class PagesController < ApplicationController

  # search paremeters for user and event
  def event_sign_in
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)

    @p = Event.ransack(params[:q])
    @events = @p.result(distinct: true)
  end

  # parameters for drop down in the event_sign _in page
  def event_check_in
    user_id = params[:user_id]
    event_id = params[:event_id]
    user = User.find(user_id)
    event = Event.find(event_id)
    user_event = UserEvent.find_by(user_id: user_id, event_id: event_id)
    if user_event
      if user_event.checked
        flash[:alert] = 'The user checked in this event before!'        
      else
        user.points+=event.points
        user.save        
        user_event.checked = true
        user_event.save
        flash[:notice] = 'The user checked in this event succesfully.'
      end      
    else
      user.points+=event.points      
      user.events << event
      user.save      
      user_event = UserEvent.find_by(user_id: user_id, event_id: event_id)
      user_event.checked = true
      user_event.save
      flash[:notice] = 'The user checked in this event succesfully.'      
    end    
  
    redirect_to pages_event_sign_in_path
  end
  
end
