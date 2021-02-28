require 'rails_helper'

RSpec.describe "Tenants", type: :request do
  # initialize test data
  let!(:tenants) { create_list(:tenant, 10) }
  let(:tenant_id) { tenants.first.id }

  # Test suite for GET /tenants
  describe 'GET /tenants' do
    # make HTTP get request before each example
    before { get '/tenants' }

    it 'returns tenants' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tenants/:id
  describe 'GET /tenants/:id' do
    before { get "/tenants/#{tenant_id}" }

    context 'when the record exists' do
      it 'returns the tenant' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(tenant_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:tenant_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tenant/)
      end
    end
  end

  # Test suite for POST /tenants
  describe 'POST /tenants' do
    # valid payload
    let(:valid_attributes) { { name: 'Cristiano Ronaldo', email: 'foo@bar.com', phone: '5565876898' } }

    context 'when the request is valid' do
      before { post '/tenants', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('Cristiano Ronaldo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/tenants', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /tenants/:id
  describe 'PUT /tenants/:id' do
    let(:valid_attributes) { { email: 'change@bar.com' } }

    context 'when the record exists' do
      before { put "/tenants/#{tenant_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{tenant_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
