RSpec.describe 'Example' do
  include FactoryBot::Syntax::Methods

  it 'is an example' do
    expect(true).to eq(true)
  end

  it 'can create a user with FactoryBot' do
    user = create(:user, name: 'John Doe')
    expect(user.name).to eq('John Doe')
  end
end
