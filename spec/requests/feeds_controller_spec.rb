require 'rails_helper'

RSpec.describe FeedsController, type: :request do
  example 'GET /feed' do
    create :post

    get '/feed.atom'

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to include('application/atom+xml')
  end
end
