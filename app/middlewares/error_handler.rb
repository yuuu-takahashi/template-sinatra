class ErrorHandler
  ERROR_MAPPING = {
    Sinatra::NotFound => 404
  }.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue StandardError => e
    handle_error(e)
  end

  private

  def handle_error(error)
    status = ERROR_MAPPING[error.class] || [500, 'Internal Server Error']
    response(status)
  end

  def response(status)
    if status == 404
      [404, { 'Content-Type' => 'text/html' }, [erb(:not_found)]]
    else
      [500, { 'Content-Type' => 'text/html' }, ['Internal Server Error']]
    end
  end
end
