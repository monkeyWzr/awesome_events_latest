class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def index
  end

  def show
    @event = Event.find(params[:id])
    @ticket = current_user && Ticket.find_by(event: @event)
    @tickets = @event.tickets.includes(:user).order(:created_at)
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    # respond_to do |format|
    #   if @event.save
    #     format.html { redirect_to @event, notice: "作成しました" }
    #     # format.js
    #     format.json { render json: @event, status: :created, location: @event }
    #   else
    #     # format.html { render action: "new" }
    #     format.js
    #     format.json { render json: @event.errors, status: :unprocessable_entity }
    #   end
    # end
    redirect_to @event, notice: "作成しました" if @event.save
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id])
    redirect_to @event, notice: "更新しました" if @event.update(event_params)
  end

  def destroy
    @event = current_user.created_events.find(params[:id])
    @event.destroy!
    redirect_to root_path, notice: "削除しました"
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :image, :remove_image, :content, :start_at, :end_at)
  end
end