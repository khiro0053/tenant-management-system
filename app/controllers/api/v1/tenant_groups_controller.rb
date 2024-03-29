class Api::V1::TenantGroupsController < Api::V1::ApiController
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :set_tenant_group, only: [:show, :update, :destroy]

  def index
    tenant_groups = current_user.company.tenant_groups
    render json: tenant_groups
  end

  def show
    render json: @tenant_group
  end

  def create
    @tenant_group = current_user.company.tenant_groups.new(tenant_group_params)
    if @tenant_group.save
      render json: @tenant_group
    else
      render json: { errors: @tenant_group.errors.keys.map {|key| [key, @tenant_group.errors.full_messages_for(key)] }.to_h }, status: :unprocessable_entity
    end
  end

  def update
    if @tenant_group.update(tenant_group_params)
      render json: @tenant_group
    else
      render json: { errors: @tenant_group.errors.keys.map {|key| [key, @tenant.errors.full_messages_for(key)] }.to_h }, status: :unprocessable_entity
    end
  end

  def destroy
    @tenant_group.destroy!
    render json: @tenant_group
  end

  private

    def set_tenant_group
      @tenant_group = current_user.company.tenant_groups.find(params[:id])
    end

    def tenant_group_params
      params.require(:tenant_group).permit(:name)
    end
end
