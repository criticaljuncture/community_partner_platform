FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email { "#{first_name}.#{last_name}@example.com".downcase }

    password 'sup3rs3cr3t!'
    password_confirmation 'sup3rs3cr3t!'

    roles { [Role.first] }
  end

  factory :organization_member, parent: :user do
    roles { [Role.find_by_identifier(:organization_member)] }
    organization_id 1
  end
end
