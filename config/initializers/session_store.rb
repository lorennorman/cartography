# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cartography_session',
  :secret      => 'ca6eb08f2fb91a84a0443b8ae44e40f2b524e6a5fa40aa5d475c0ce2b27786e69d285b096e6276d4b5315f3f5d6c70e728f76c79055d50bab88ada0887d9ee3b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
