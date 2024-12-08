# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/user'

RSpec.describe 'Example' do
  include FactoryBot::Syntax::Methods

  it 'is an example' do
    expect(true).to eq(true)
  end

  it 'can create a user with FactoryBot' do
    user = build(:user)
    expect(user.name).to eq('John Doe')
  end
end
