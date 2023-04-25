class PagesController < ApplicationController
  def event_sign_in
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc)

    @p = Event.ransack(params[:q])
    @events = @p.result(distinct: true).order(created_at: :asc)
    @event_id = params[:event_id]
  end

  def about; end

  def event_check_in
    uin = params[:uin]
    event_id = params[:event_id]
    user = User.find_by(uin: uin)
    user_id = user.id
    event = Event.find(event_id)
    user_event = UserEvent.find_by(user_id: user_id, event_id: event_id)
    if user_event
      if user_event.checked
        flash[:alert] = 'The user checked in this event before!'
      else
        user.points += event.points
        user.save
        user_event.checked = true
        user_event.save
        event.count += 1
        event.save
        flash[:notice] = 'The user checked in this event succesfully.'
      end
    else
      user.points += event.points
      user.events << event
      user.save
      user_event = UserEvent.find_by(user_id: user_id, event_id: event_id)
      user_event.checked = true
      user_event.save
      event.count += 1
      event.save
      flash[:notice] = 'The user checked in this event succesfully.'
    end

    redirect_to(pages_event_sign_in_path(event_id: event_id))
  end

  def reset_user_points; end

  def post_reset_user_points
    user = User.find_by(uin: params[:uin])
    user.points = 0
    user.save
    flash[:notice] = 'User points succesfully reset to zero.'
    redirect_to(pages_reset_user_points_path)
  end
end
