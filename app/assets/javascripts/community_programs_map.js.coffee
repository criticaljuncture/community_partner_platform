$(document).ready ->
  if $('#community-programs-map').length > 0
    new CPP.CommunityProgramsMap(
      $('#community-programs-map'),
      {
        bearing: 30,
        center: [-122.2120, 37.8031],
        maxBounds: [
          [-122.39955550642291, 37.67451729486625], # Southwest coordinates
          [-122.02715595408341, 37.92691743936612]  # Northeast coordinates
        ],
        zoom: 11.34
      }
    )
