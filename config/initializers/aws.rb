creds = Aws::Credentials.new(
  Rails.application.secrets.aws[:access_key_id],
  Rails.application.secrets.aws[:secret_access_key]
)

Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials: creds,
  region: 'us-east-1'
)
