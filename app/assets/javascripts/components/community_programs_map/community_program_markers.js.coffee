class @CPP.CommunityProgramMarkers
  @layers:
    "Elementary": [30, '#f28cb1', '#f4a3c0'],
    "Middle": [15, '#f1f075', '#f6f6ac'],
    "Senior": [0, '#51bbd6', '#73c8de']

  @add: (map, site_type_norm)->
    @addCommunityProgramSource(map, site_type_norm)
    @addCommunutyProgramMarkers(map, site_type_norm)
    @addCommunutyProgramMarkerClustering(map, site_type_norm)

  @addCommunityProgramSource: (map, site_type_norm)->
    map.addSource("community-program-markers-#{site_type_norm}", {
      type: "geojson",
      data: "/api/school_community_program_markers/#{site_type_norm}",
      cluster: false,
      clusterMaxZoom: 14,
      clusterRadius: 50
    })

  @addCommunutyProgramMarkers: (map, site_type_norm)->
    map.addLayer({
        "id": "non-cluster-markers-blur-#{site_type_norm}",
        "type": "circle",
        "source": "community-program-markers-#{site_type_norm}",
        "paint": {
            "circle-color": @layers[site_type_norm][2],
            "circle-radius": 22
        }
    });

    map.addLayer({
        "id": "non-cluster-markers-#{site_type_norm}",
        "type": "circle",
        "source": "community-program-markers-#{site_type_norm}",
        "paint": {
            "circle-color": @layers[site_type_norm][1],
            "circle-radius": 18
        }
    });

    map.addLayer({
        "id": "program-count-label-#{site_type_norm}",
        "type": "symbol",
        "source": "community-program-markers-#{site_type_norm}",
        "layout": {
            "text-field": "{programCount}",
            "text-font": [
                    "DIN Offc Pro Medium",
                    "Arial Unicode MS Bold"
                ],
            "text-size": 12
        }
    });


  @addCommunutyProgramMarkerClustering: (map, site_type_norm)->
    cppMarkers = this

    #Add a layer for the clusters' count labels
    map.addLayer({
      "id": "cluster-count-#{site_type_norm}",
      "type": "symbol",
      "source": "community-program-markers-#{site_type_norm}",
      "layout": {
        "text-field": "{programCount}",
        "text-font": [
          "DIN Offc Pro Medium",
          "Arial Unicode MS Bold"
        ],
        "text-size": 12
      }
    })
