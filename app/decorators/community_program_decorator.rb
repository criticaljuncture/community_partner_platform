class CommunityProgramDecorator < Draper::Decorator
  delegate_all

  def verification_header
    "#{should_verify?(h.current_user) ? 'Verify' : 'Edit'} #{name}"
  end
end
