roles = [
  ['Super Admin', :super_admin],
  ['District Manager', :district_manager],
  ['School Manager', :school_manager],
  ['Organization Member', :organization_member]
]

Role.delete_all
roles.each do |name, identifier|
  r = Role.new(name: name, identifier: identifier)
  r.save
end
