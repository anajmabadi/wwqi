# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
Rails.application.config.session_store :cookie_store, :key => '_qajar_session',
  :secret => '6d7d0675cad82881723747043409088ef10a980dcf5fc52229c53b47820031e882138603e32dbd58f28c06755034a24c11285aed06f5f428d7a3f88a58b25cf8'
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
