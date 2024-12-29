# frozen_string_literal: true

get '/' do
  'TOP'
end

ROUTES = {
  get: {
    '/users' => [UsersController, :index],
    '/users/:id' => [UsersController, :show]
  }
}.freeze

ROUTES.each do |http_method, paths|
  paths.each do |path, (controller, action)|
    send(http_method, path) do
      controller.send(action, params)
    end
  end
end
