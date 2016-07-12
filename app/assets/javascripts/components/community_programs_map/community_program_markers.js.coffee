class @CPP.CommunityProgramMarkers
  @layers: [
    [150, '#f28cb1', '#f4a3c0'],
    [20, '#f1f075', '#f6f6ac'],
    [0, '#51bbd6', '#73c8de']
  ]

  @add: (map)->
    @addCommunityProgramSource(map)
    @addCommunutyProgramMarkers(map)
    @addCommunutyProgramMarkerClustering(map)

  @addCommunityProgramSource: (map)->
    map.addSource("earthquakes", {
      type: "geojson",
      data: "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_month.geojson",
      cluster: true,
      clusterMaxZoom: 14,
      clusterRadius: 50
    })

  @addCommunutyProgramMarkers: (map)->
    map.addLayer({
        "id": "non-cluster-markers-blur",
        "type": "circle",
        "source": "earthquakes",
        "paint": {
            "circle-color": @layers[2][2],
            "circle-radius": 22
        }
    });

    map.addLayer({
        "id": "non-cluster-markers",
        "type": "circle",
        "source": "earthquakes",
        "paint": {
            "circle-color": @layers[2][1],
            "circle-radius": 18
        }
    });

    map.addLayer({
        "id": "magnitude-label",
        "type": "symbol",
        "source": "earthquakes",
        "layout": {
            "text-field": "{mag}",
            "text-font": [
                    "DIN Offc Pro Medium",
                    "Arial Unicode MS Bold"
                ],
            "text-size": 12
        }
    });

  @addCommunutyProgramMarkerClustering: (map)->
    cppMarkers = this

    _.each @layers, (layer, index)->
      map.addLayer({
        "id": "non-cluster-markers-blur-" + index,
        "type": "circle",
        "source": "earthquakes",
        "paint": {
          "circle-color": layer[2],
          "circle-radius": 22
        },
        "filter": if index == 0 then [">=", "point_count", layer[0]] else
            ["all",
              [">=", "point_count", layer[0]],
              ["<", "point_count", cppMarkers.layers[index - 1][0]]]
      })

      map.addLayer({
          "id": "cluster-" + index,
          "type": "circle",
          "source": "earthquakes",
          "paint": {
              "circle-color": layer[1],
              "circle-radius": 18
          },
          "filter": if index == 0 then [">=", "point_count", layer[0]] else
              ["all",
                  [">=", "point_count", layer[0]],
                  ["<", "point_count", cppMarkers.layers[index - 1][0]]]
      })

    #Add a layer for the clusters' count labels
    map.addLayer({
      "id": "cluster-count",
      "type": "symbol",
      "source": "earthquakes",
      "layout": {
        "text-field": "{point_count}",
        "text-font": [
          "DIN Offc Pro Medium",
          "Arial Unicode MS Bold"
        ],
        "text-size": 12
      }
    })
