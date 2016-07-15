class @CPP.CommunityProgramMarkers
  @layers:
    "Elementary": [30, '#ef75a1', '#f4a3c0'],
    "Middle": [15, '#f1f17e', '#f6f6ac'],
    "Senior": [0, '#4ab8d4', '#73c8de']

  @add: (map, site_type_norm)->
    @addCommunityProgramSource(map, site_type_norm)
    @addCommunutyProgramMarkers(map, site_type_norm)
    @addCommunutyProgramMarkerClustering(map, site_type_norm)
    @addTooltips(map, site_type_norm)
    @addLegend(map, site_type_norm)

  @addLegend: (map, site_type_norm) ->
    legend_item_link = $(
      HandlebarsTemplates['legend_item']({
        "school-type-class": site_type_norm.toLowerCase(),
        "site_type_norm": site_type_norm
      })
    )

    legend_item_link.appendTo('#menu ul')

    legend_item_link.on "click", (e) ->
      e.preventDefault()
      e.stopPropagation()
      _.each [
        "non-cluster-markers-blur-"
        "non-cluster-markers-"
        "program-count-label-"
        "cluster-count-"
      ], (layerType) ->
        layer = layerType + site_type_norm
        visibility = map.getLayoutProperty(layer, 'visibility')
        if visibility == 'visible'
          map.setLayoutProperty layer, 'visibility', 'none'
          @className = ''
        else
          @className = 'active'
          map.setLayoutProperty layer, 'visibility', 'visible'

  @addCommunityProgramSource: (map, site_type_norm)->
    map.addSource("community-program-markers-#{site_type_norm}", {
      type: "geojson",
      data: "/api/community_program_markers/#{site_type_norm}",
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
        },
        "layout": {
          "visibility": "visible"
        }
    });

    map.addLayer({
        "id": "non-cluster-markers-#{site_type_norm}",
        "type": "circle",
        "source": "community-program-markers-#{site_type_norm}",
        "paint": {
            "circle-color": @layers[site_type_norm][1],
            "circle-radius": 18
        },
        "layout": {
          "visibility": "visible"
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
            "text-size": 12,
            "visibility": "visible"
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
        "text-size": 12,
        "visibility": "visible"
      }
    })

  @addTooltips: (map, site_type_norm)->
    popup = new (mapboxgl.Popup)(
      closeButton: false
      closeOnClick: false)

    map.on 'mousemove', (e) ->
      features = map.queryRenderedFeatures(
        e.point,
        layers: [ "non-cluster-markers-blur-#{site_type_norm}" ] )

      # Change the cursor style as a UI indicator.

      map.getCanvas().style.cursor = if features.length then 'pointer' else ''
      if !features.length
        popup.remove()
        return
      feature = features[0]

      # Populate the popup and set its coordinates
      # based on the feature found.
      popup.setLngLat(feature.geometry.coordinates).setHTML(feature.properties.description).addTo map
      return
