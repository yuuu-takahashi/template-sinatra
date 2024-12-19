# frozen_string_literal: true

require_relative '../../config/setup'
require_with_alias('@/index')

RSpec.describe 'users_controller' do
  it 'users' do
    create_list(:user, 3)
    get '/users'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body).size).to eq(3)
  end

  it 'user' do
    user = create(:user)
    get "/users/#{user.id}"
    expect(last_response).to be_ok
  end
end
