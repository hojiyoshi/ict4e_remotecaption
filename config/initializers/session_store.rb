# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ict4e_remotecaption_session',
  :secret      => '743ffde91a2e157448e41dd8f8f106ff73369ef60332cecbd3d09160d75c4bdd2fd4be054cd5f4c4f88fdc6bbf766d17ffdd81188a3cbfd64e0125713c174522'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
