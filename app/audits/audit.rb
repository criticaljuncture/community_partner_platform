module Audit
  extend ActiveSupport::Concern

  included do
    attr_accessor :associations, :current_user_id

    has_paper_trail :meta => {
      associations: :associations_for_audit
    }

    after_create :update_association_versions
    after_update :update_association_versions

    private

    def changed_notably?
      @manual_version || super
    end
  end

  def update_version
    @manual_version = true
    record_update.try(:save)
    @manual_version = false
  end

  def update_association_versions
    # noop stub - implemented in specific audit modules
  end
end
