class Api::V1::TenantsController < Api::V1::ApiController
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :set_tenant, only: [:show, :update, :destroy]

  def index
    tenants = current_user.company.tenants
    render json: tenants
  end

  def show
    render json: @tenant
  end

  def create
    tenant = current_user.company.tenants.create!(tenant_params)
    render json: tenant
  end

  def update
    @tenant.update!(tenant_params)
    render json: @tenant
  end

  def destroy
    @tenant.destroy!
    render json: @tenant
  end

  private

    def set_tenant
      @tenant = current_user.company.tenants.find(params[:id])
    end

    def tenant_params
      params.require(:tenant).permit(:name, :target_number_of_residents, :capacity, :area_id)
    end
end
