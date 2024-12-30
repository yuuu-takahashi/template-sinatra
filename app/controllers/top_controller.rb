class TopController < Sinatra::Base
  def self.index(params = {})
    puts params
    'Hello, world!'
  end
end
