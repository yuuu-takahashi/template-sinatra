class TopController < Sinatra::Base
  def self.index(_params = {})
    'Hello, world!'
  end
end
