FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email { "#{first_name}.#{last_name}@example.com".downcase }

    password 'supers3c3t!'
    password_confirmation 'supers3c3t!'

    roles { [Role.find_by_identifier(:organization_member)] }
  end
end
