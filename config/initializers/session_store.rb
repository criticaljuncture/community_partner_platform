# Be sure to restart your server when you modify this file.

OusdCommunityPartners::Application.config.session_store :cookie_store,
  key: '_ousd_community_partners_session',
  # Only send cookie over SSL when in production mode
  secure: Rails.env.production? ? true : false,
  # Don't allow Javascript to access the cookie (mitigates cookie-based XSS exploits)
  httponly: true
