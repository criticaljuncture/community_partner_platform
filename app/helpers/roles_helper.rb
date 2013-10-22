module RolesHelper
  def role_view(role, user)
    case role.identifier.to_sym
    when :school_manager
      view = role_view_for_school_mangager(role, user.schools)
    when :organization_member
      view = role_view_for_organization_member(role, user.organization)
    end

    role_header(role) + view
  end

  def role_header(role)
    content_tag(:dt, 'Role') + 
      content_tag(:dd, role.name)
  end

  def role_view_for_school_mangager(role, schools)
    content_tag(:dt, 'Schools') + 
      content_tag(
        :dd,
        join_with_br( schools.map{|school| link_to(school.name, school_path(school)) } )
      )
  end
  
  def role_view_for_organization_member(role, organization)
    content_tag(:dt, 'Organization') + 
      content_tag(
        :dd,
        link_to(organization.name, organization_path(organization))
      )
  end
end
