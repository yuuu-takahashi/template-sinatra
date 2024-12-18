# frozen_string_literal: true

require_relative '../../config/setup'
require_with_alias('@/index')

RSpec.describe 'users_controller' do
  it 'users' do
    get '/users'
    expect(last_response).to be_ok
  end

  # it 'user' do
  #   user = create(:user)
  #   get "/users/#{user.id}"
  #   expect(last_response).to be_ok
  # end
end
