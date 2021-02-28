require 'rails_helper'

RSpec.describe "Properties", type: :request do
  # Initialize the test data
  let!(:tenant) { create(:tenant) }
  let!(:properties) { create_list(:property, 20, tenant_id: tenant.id) }
  let(:tenant_id) { tenant.id }
  let(:id) { properties.first.id }

  # Test suite for GET /tenants/:tenant_id/properties
  describe 'GET /tenants/:tenant_id/properties' do
    before { get "/tenants/#{tenant_id}/properties" }

    context 'when tenant exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tenant properties' do
        expect(json.size).to eq(20)
      end
    end

    context 'when tenant does not exist' do
      let(:tenant_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tenant/)
      end
    end
  end

  # Test suite for GET /tenants/:tenant_id/properties/:id
  describe 'GET /tenants/:tenant_id/properties/:id' do
    before { get "/tenants/#{tenant_id}/properties/#{id}" }

    context 'when tenant property exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the property' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when tenant property does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end
  end

  # Test suite for POST /tenants/:tenant_id/properties
  describe 'POST /tenants/:tenant_id/properties' do
    let(:valid_attributes) { { name: 'Roma Norte', description: "Lorem Impusium", rental_price: 1234.12, status: 1 } }

    context 'when request attributes are valid' do
      before { post "/tenants/#{tenant_id}/properties", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/tenants/#{tenant_id}/properties", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /tenants/:tenant_id/properties/:id
  describe 'PUT /tenants/:tenant_id/properties/:id' do
    let(:valid_attributes) { { name: 'Roma Sur' } }

    before { put "/tenants/#{tenant_id}/properties/#{id}", params: valid_attributes }

    context 'when property exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the property' do
        updated_property = Property.find(id)
        expect(updated_property.name).to match(/Roma Sur/)
      end
    end

    context 'when the property does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end
  end

  # Test suite for DELETE /tenants/:id
  describe 'DELETE /tenants/:id' do
    before { delete "/tenants/#{tenant_id}/properties/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
