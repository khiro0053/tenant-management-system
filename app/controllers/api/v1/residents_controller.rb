class Api::V1::ResidentsController < Api::V1::ApiController
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :set_resident, only: [:show, :update, :destroy]

  def index
    residents = Resident.where(tenant_id: current_user.company.tenants.ids)
    render json: residents
  end

  def show
    render json: @resident
  end

  def create
    @resident = Resident.new(resident_params)
    if @resident.save
      render json: @resident
    else
      render json: { errors: @resident.errors.keys.map {|key| [key, @resident.errors.full_messages_for(key)] }.to_h }, status: :unprocessable_entity
    end
  end

  def update
    if @resident.update(resident_params)
      render json: @resident
    else
      render json: { errors: @resident.errors.keys.map {|key| [key, @resident.errors.full_messages_for(key)] }.to_h }, status: :unprocessable_entity
    end
  end

  def destroy
    @resident.destroy!
    render json: @resident
  end

  private

    def set_resident
      @resident = Resident.find(params[:id])
    end

    def resident_params
      params.require(:resident).permit(:care_level, :first_name, :last_name, :is_hospitalized, :tenant_id)
    end
end
