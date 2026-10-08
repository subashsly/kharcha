source "https://rubygems.org"

gem "rails", "~> 8.1.4"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

# Authentication & Security
gem "bcrypt", "~> 3.1.7" # Uncommented: Required for has_secure_password
gem "jwt", "~> 3.3"      # Added: For encoding/decoding short-lived access tokens
gem "rack-cors"          # Uncommented: Required for React Native to talk to this API
gem "rack-attack"        # Added: Rate-limits brute force logins and expensive AI calls

# Data, Pagination & Authorization
gem "pagy", "~> 43.7"    # Added: High-performance pagination for financial feeds
gem "pundit"             # Added: Enforces strict object-level authorization (current_user only)

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"        # Rails 8 native database-backed background jobs (replaces Sidekiq/Redis)
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

# Removed: jbuilder (JSON APIs will use standard Ruby hashes/serializers for better performance)
# Removed: image_processing (Wait until Phase 2 when you actually add receipt scanning)

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Added: The automated testing suite required for financial ledger correctness
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "faker"
  gem "vcr"              # Crucial: Mocks AI network calls so your tests run instantly and for free
  gem "webmock"          # Pairs with VCR to block accidental real API requests in tests

  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end
