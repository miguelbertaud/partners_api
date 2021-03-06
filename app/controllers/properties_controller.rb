class PropertiesController < ApplicationController
  before_action :set_tenant
  before_action :set_tenant_property, only: [:show, :update, :destroy]
  before_action :authenticate, only: [ :index_published ]
  include Response
  include ExceptionHandler
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  TOKEN = "secret"

  has_scope :by_name, only: [:index]
  has_scope :by_price, only: [:index]
  has_scope :by_status, only: [:index]

  # GET /tenants/:tenant_id/properties
  def index
    json_response(@tenant.properties.not_published)
  end

  def index_published
    json_response(@tenant.properties.published)
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

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end

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
