require 'rails_helper'

RSpec.describe FeedsController, type: :request do
  example 'GET /feed' do
    create :post, body: '# hello world'

    get '/feed.atom'

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to include('application/atom+xml')

    content  = Nokogiri::XML.parse(response.body).at_css('content')
    fragment = Nokogiri::HTML::DocumentFragment.parse(content.text)

    expect(fragment.at_css('h1').text).to eq('hello world')
  end
end
