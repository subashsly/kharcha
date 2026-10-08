# config/initializers/rack_attack.rb
class Rack::Attack
  # Use the Rails cache (Solid Cache) for rate limiting
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Limit logins/registrations to 5 requests per minute per IP
  throttle("auth/ip", limit: 5, period: 1.minute) do |req|
    if req.path.start_with?("/api/v1/auth") && req.post?
      req.ip
    end
  end

  # Limit AI Parse Entry to 10 requests per minute per user (prevent runaway AI costs)
  throttle("ai_parse/user", limit: 10, period: 1.minute) do |req|
    if req.path == "/api/v1/transaction_drafts/parse" && req.post?
      # Assuming you extract the user ID from the JWT header in Rack middleware
      # Alternatively, limit by IP if parsing JWT here is too slow
      req.ip
    end
  end

  # Standard API rate limit (100 req / minute per IP)
  throttle("req/ip", limit: 100, period: 1.minute) do |req|
    req.ip
  end

  # Custom JSON response when rate limited
  self.throttled_responder = lambda do |request|
    [
      429,
      { "Content-Type" => "application/problem+json" },
      [ {
        type: "https://api.kharcha.app/errors/rate_limited",
        title: "Too Many Requests",
        status: 429,
        detail: "You have exceeded your request limit. Please try again later."
      }.to_json ]
    ]
  end
end
