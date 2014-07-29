module CommunityProgramsHelper
  def link_to_toggle_program_active_state(community_program)
    button_text = community_program.active? ? 'Deactivate' : 'Activate'

    link_to button_text, '#',
      class: 'btn btn-warning',
      :'data-toggle' => "modal",
      :'data-target' => "#deactivation-warning-modal",
      :'data-options' => {escapeClose: false,
                          clickClose: false,
                          showClose: false}.to_json
  end
end
