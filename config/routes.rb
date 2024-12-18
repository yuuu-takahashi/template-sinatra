# frozen_string_literal: true

require_with_alias('@/app/controllers/users_controller')

get '/' do
  'TOP'
end

ROUTES = {
  get: {
    '/users' => [UsersController, :index]
    # '/users/:id' => [UsersController, :show]
  }
}.freeze

ROUTES.each do |http_method, paths|
  paths.each do |path, (controller, action)|
    send(http_method, path) do
      if params.empty?
        controller.send(action)
      else
        controller.send(action, params)
      end
    end
  end
end
