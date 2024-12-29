RSpec.describe 'top_controller' do
  it '/' do
    get '/'
    expect(last_response).to be_ok
  end
end
