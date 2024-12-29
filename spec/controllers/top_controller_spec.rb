# frozen_string_literal: true

require_relative '../../config/environment'
require_with_alias('@/index')

RSpec.describe 'top_controller' do
  it '/' do
    get '/'
    expect(last_response).to be_ok
  end
end
