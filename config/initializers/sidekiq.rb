# frozen_string_literal: true

redis_url = ENV["REDIS_URL"].presence ||
  (Rails.env.production?? nil : "redis://localhost:6379/0")

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, reconnect_attempts: 1, protocol: 2 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, reconnect_attempts: 1, protocol: 2 }
end
