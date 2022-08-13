class Api::V1::RoomsController < Api::V1::ApiController
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :set_room, only: [:show, :update, :destroy]

  def index
    rooms = Room.where(tenant_id: current_user.company.tenants.ids)
    render json: rooms
  end

  def show
    render json: @room
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render json: @room
    else
      render json: { errors: @room.errors.keys.map {|key| [key, @room.errors.full_messages_for(key)] }.to_h }, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: { errors: @room.errors.keys.map {|key| [key, @room.errors.full_messages_for(key)] }.to_h }, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy!
    render json: @room
  end

  private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name, :seating_capacity, :tenant_id)
    end
end
