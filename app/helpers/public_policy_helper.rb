module PublicPolicyHelper
  def missing_requirements_tooltip(model)
    "Can not be made public for the following reasons: <ul><li>#{model.public_policy.missing_requirements.join('</li><li> ')}</li></ul>"
  end
end
