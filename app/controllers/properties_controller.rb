class PropertiesController < ApplicationController
  before_action :set_tenant
  before_action :set_tenant_property, only: [:show, :update, :destroy]
  include Response
  include ExceptionHandler

  has_scope :by_name, only: [:index]
  has_scope :by_price, only: [:index]
  has_scope :by_status, only: [:index]

  # GET /tenants/:tenant_id/properties
  def index
    json_response(@tenant.properties.not_published)
  end

  # GET /tenants/:tenant_id/properties/:id
  def show
    json_response(@property)
  end

  # POST /tenants/:tenant_id/properties
  def create
    @tenant.properties.create!(property_params)
    json_response(@tenant, :created)
  end

  # PUT /tenants/:tenant_id/properties/:id
  def update
    @property.update(property_params)
    head :no_content
  end

  # DELETE /tenants/:tenant_id/properties/:id
  def destroy
    @property.destroy
    head :no_content
  end

  private

  def property_params
    params.permit(:name, :description, :rental_price, :status)
  end

  def set_tenant
    @tenant = Tenant.find(params[:tenant_id])
  end

  def set_tenant_property
    @property = @tenant.properties.find_by!(id: params[:id]) if @tenant
  end
end
