$(document).ready ->
  if $('#community-programs-map').length > 0
    $.ajax({
      url: '/api/config/school_map.json'
    })
    .done (data)->
      new CPP.CommunityProgramsMap(
        $('#community-programs-map'),
        data
      )
