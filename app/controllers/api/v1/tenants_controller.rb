class Api::V1::TenantsController < Api::V1::ApiControllers
  before_action :set_tenant, only: [:show :update, :destroy]
  def index
    tenants = Tenant.all
    render json: tenants
  end

  def show
    render json: @tenant
  end

  def create
    tenant = current_user.tenants.create!(tenant_params)
    render json: tenant
  end

  def update
    @tenant.update!(tenant_params)
    render json: @tenant
  end

  def destroy
    @tenant.destroy!(tenant_params)
    render json: @tenant
  end

  private
  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.require(:tenant).permit(:name, :target_number_of_residents)
  end
end
