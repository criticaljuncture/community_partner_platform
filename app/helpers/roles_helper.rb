module RolesHelper
  def role_view(role, user)
    case role.identifier.to_sym
    when :school_manager
      view = role_view_for_school_mangager(role, user.schools)
    when :organization_member
      view = role_view_for_organization_member(role, user.organization)
    end

    role_header(role, user) + view
  end

  def role_header(role, user)
    content_tag(:dt, 'Role') + 
      content_tag(:dd) do
        delete_button = user.primary_role == role ? '' : link_to('Delete', user_role_path(user, user.user_roles.where(role_id: role.id).first.id), method: :delete, class: "btn btn-small btn-danger")
        (role.name + delete_button).html_safe
      end
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
