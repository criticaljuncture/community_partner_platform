# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
  key: '_community_partner_platform_session',
  # Only send cookie over SSL when in production mode
  secure: Rails.env.production? ? true : false,
  # Don't allow Javascript to access the cookie (mitigates cookie-based XSS exploits)
  httponly: true
