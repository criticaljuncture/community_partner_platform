module PublicPolicyHelper
  def missing_requirements_tooltip(model, options={org_check: true})
    missing_requirements = model.public_policy.missing_requirements(org_check: options[:org_check])
    return nil unless missing_requirements.present?
    
    "Can not be made public for the following reasons: #{missing_requirements_list(missing_requirements)}"
  end

  def missing_requirements_list(missing_requirements)
    "<ul><li>#{missing_requirements.join('</li><li>')}</li></ul>"
  end
end
