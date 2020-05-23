require 'rails_helper'

RSpec.describe 'JuliaParam API', type: :request do
  # initialize test data
  let!(:julia_params) { create_list(:julia_param, 1) }
  let(:julia_params_id) { todos.first.id }

  # # Test suite for POST /julia_params
  # describe 'GET /julia_params' do
  #   # make HTTP get request before each example
  #   #before { get '/todos' }

  #   it 'returns todos' do
  #     # Note `json` is a custom helper to parse JSON responses
  #     expect(json).not_to be_empty
  #     expect(json.size).to eq(1)
  #   end

  #   it 'returns status code 200' do
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe 'POST /julia_params' do
    # valid payload
    let(:test_param) { { min_x: 1, max_x: 2, min_y: 3, max_y: 4, comp_const: 5 } }

    context 'when the request is valid' do
      before { post '/julia_params', params: test_param }

      it 'creates a juliaparam' do
        expect(json['min_x']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/julia_params', params: { comp_const: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end
end
