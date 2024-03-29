class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :check_create_permissions, only: %i[new create]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to(events_path, notice: 'Event was successfully created.') }
        format.json { render(:show, status: :created, location: @event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to(event_url(@event), notice: 'Event was successfully updated.') }
        format.json { render(:show, status: :ok, location: @event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url, notice: 'Event was successfully deleted.') }
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
  def set_event
    @event = Event.find(params[:id])
  end

  def check_create_permissions
    if current_admin.user&.role_id == 3 || current_admin.user&.role_id == nil
      flash[:alert] = "You are not authorized to create an event."
      redirect_to events_path
    end
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:start, :end, :status, :type_id, :name, :description, :points)
  end
end
