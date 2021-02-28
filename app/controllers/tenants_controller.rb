class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :update, :destroy]
  include Response
  include ExceptionHandler

  has_scope :by_name, :by_email, :by_phone

  # GET /tenants
  def index
    @tenants = apply_scopes(Tenant).all
    json_response(@tenants)
  end

  # POST /tenants
  def create
    @tenant = Tenant.create!(tenant_params)
    json_response(@tenant, :created)
  end

  # GET /tenants/:id
  def show
    json_response(@tenant)
  end

  # PUT /tenants/:id
  def update
    @tenant.update(tenant_params)
    head :no_content
  end

  # DELETE /tenants/:id
  def destroy
    @tenant.destroy
    head :no_content
  end

  private

  def tenant_params
    # whitelist params
    params.permit(:name, :email, :phone)
  end

  def set_tenant
    @tenant = Tenant.find(params[:id])
  end
end
