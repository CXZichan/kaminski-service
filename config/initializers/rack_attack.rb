Rails.application.config.middleware.use Rack::Attack

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle("contact requests by ip", limit: 5, period: 10.minutes) do |request|
  request.ip if request.post? && request.path == "/kontakt"
end

Rack::Attack.throttled_responder = lambda do |_request|
  [ 429, { "Content-Type" => "text/plain" }, [ "Zu viele Anfragen. Bitte versuchen Sie es später erneut." ] ]
end
