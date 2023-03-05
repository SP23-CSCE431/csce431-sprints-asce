class UserEventsController < ApplicationController
  before_action :set_user_event, only: %i[show edit update destroy]

  # GET /user_events or /user_events.json
  # the index path simply displays all user_events ie. all events that are specifically signed up by a user and tied to them
  def index
    @user_events = UserEvent.all
  end

  # GET /user_events/1 or /user_events/1.json
  # the show path shows a specific event that is tied to a user that they have signed up for
  def show; end

  # GET /user_events/new
  # the new path is where users can add events they want to sign up for and the eventId variable is in the url so it can autofill the event id field of a specific
  # event that the user wants to sign up for
  def new
    @user_event = UserEvent.new
    @eventId = params[:eventId]
  end

  # GET /user_events/1/edit
  def edit; end

  # POST /user_events or /user_events.json
  # this method actually creates the new user_event record and officially adds it to the table representing that the user has successfully signed up for an event
  # input fields with the user id and event id that are autofilled for the user
  def create
    @user_event = UserEvent.new(user_event_params)

    respond_to do |format|
      if @user_event.save
        format.html { redirect_to(user_event_url(@user_event), notice: 'User event was successfully created.') }
        format.json { render(:show, status: :created, location: @user_event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user_event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /user_events/1 or /user_events/1.json
  def update
    respond_to do |format|
      if @user_event.update(user_event_params)
        format.html { redirect_to(user_event_url(@user_event), notice: 'User event was successfully updated.') }
        format.json { render(:show, status: :ok, location: @user_event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user_event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /user_events/1 or /user_events/1.json
  # This method allows a user to successfully destroy a record of an event they signed up from the table, ie. unsign up for an event that is on record for their account
  def destroy
    @user_event.destroy

    respond_to do |format|
      format.html { redirect_to(user_events_url, notice: 'User event was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  # Handles calendar actions by getting all events that need to be stored on calendar
  def calendar
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = Event.all
    @events_by_date = @events.group_by(&:date)
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_event
    @user_event = UserEvent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_event_params
    params.require(:user_event).permit(:user_id, :event_id)
  end
end
