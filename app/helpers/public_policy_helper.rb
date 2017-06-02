module PublicPolicyHelper
  def missing_requirements_tooltip(model)
    "Can not be made public for the following reasons: #{missing_requirements_list(model.public_policy.missing_requirements)}"
  end

  def missing_requirements_list(missing_requirements)
    "<ul><li>#{missing_requirements.join('</li><li>')}</li></ul>"
  end
end
