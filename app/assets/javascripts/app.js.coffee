$(document).ready ->
  # add tab behavior
  $('.nav.nav-tabs a').on 'click', (event)->
    event.preventDefault()
    $(this).tab('show')

  $('.nav.nav-tabs li').on 'click', (event)->
    event.preventDefault()
    $(this).find('a').tab('show')

  # make the active tab/pane visible
  activePane = $('.tab-content .tab-pane.active').attr('id')
  $('.nav.nav-tabs a')
    .filter("[href=##{activePane}]")
    .tab('show')

  #allow for direct navigation to a particular tab on a page
  queryKeys = $.parsequery(location.search).keys
  activeTab = queryKeys["active_tab"]

  if activeTab
    $("a[data-toggle='tab'][href='##{active_tab}']").trigger('click')

  # remove error state when an input is changed
  $('form.formtastic div.input.required.error').on 'change', 'input, select', ()->
    el = $(this)

    if el.val() != ""
      el.closest('div.input.required').removeClass('error')


  # show first tab
  setTimeout(
    ()->
      # select first tab on page load
      $('.nav.nav-tabs').find('a').first().tab('show')
    , 25
  )

  sortableTable = $("table.table-sorter");
  if sortableTable.length > 0
    new CJ.Tablesorter(sortableTable)


  CJ.Tooltip.addTooltip(
    '.cj-tooltip',
    {
      opacity: 1
      delay: 0.2
      fade: true
      offset: 5
    }
  )

  CJ.Tooltip.addFancyTooltip(
    '.cj-fancy-tooltip',
    {
      opacity: 1
      delay: 0.2
      fade: true
    },
    {
      position: 'centerTop'
      verticalOffset: -13
      horizontalOffset: -6
    }
  )

  CJ.Tooltip.addTooltip(
    '.form-group .icon-cpp-globe',
    {
      offset: 5,
      title: ->
        'This field will be viewable by the public.'
    }
  )

  CJ.Tooltip.addTooltip(
    '.form-group .control-label.required abbr',
    {
      title: ->
        'This field is required.'
    }
  )

  # admin dashboard, community_program and organization show pages
  CJ.Tooltip.addFancyTooltip(
    '.cj-org-progress-tooltip',
    {
      opacity: 1
      delay: 0.2
      fade: true
      html: true
      className: 'organization-status-tooltip tooltip'
    },
    {
      position: 'centerTop'
      verticalOffset: -13
      horizontalOffset: -6
    }
  )

  CJ.Tooltip.addFancyTooltip(
    '.cj-cp-progress-tooltip',
    {
      opacity: 1
      delay: 0.2
      fade: true
      html: true
      className: 'community-program-status-tooltip tooltip'
    },
    {
      position: 'centerTop'
      verticalOffset: -13
      horizontalOffset: -6
    }
  )

  CJ.Tooltip.addFancyTooltip(
    '.cj-public-policy-missing-requirements-tooltip',
    {
      opacity: 1
      delay: 0.2
      fade: true
      html: true
      className: 'public-policy-missing-requirements-tooltip tooltip'
    },
    {
      position: 'centerTop'
      verticalOffset: 3
      horizontalOffset: -20
    }
  )

  # change page on selection
  $(document).ready ->
    goto_forms = $('form.goto-selection')
    if goto_forms.length > 0
      goto_forms.each (index, element) ->
        new CPP.GotoSelector($(element))

$(document).on(
  {
    'show.bs.modal': ()->
      zIndex = 1040 + (10 * $('.modal:visible').length)
      $(this).css('z-index', zIndex)

      setTimeout(
        ()->
          $('.modal-backdrop')
            .not('.modal-stack')
            .css('z-index', zIndex - 1)
            .addClass('modal-stack')
        , 0
      )

    'hidden.bs.modal': ()->
      if $('.modal:visible').length > 0
        # restore the modal-open class to the body element, so that scrolling
        # works properly after de-stacking a modal.
        setTimeout(
          ()->
            $(document.body).addClass('modal-open')
          , 0
        )

      if $(this).hasClass('ajax-modal')
        $(this).find('.modal-body')
          .html $('<div>').addClass('loader loading')

  },
  '.modal'
)
