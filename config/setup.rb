# frozen_string_literal: true

APP_ROOT = File.expand_path('..', __dir__)

def require_with_alias(path)
  require path.sub('@/', "#{APP_ROOT}/")
end
