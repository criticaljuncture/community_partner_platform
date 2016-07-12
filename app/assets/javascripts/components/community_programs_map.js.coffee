#= require components/community_programs_map/community_program_markers

class @CPP.CommunityProgramsMap
  accessToken: 'pk.eyJ1IjoiY3JpdGljYWxqdW5jdHVyZSIsImEiOiJjaXExZjdkdWUwMHg0Zndub255c3I0OGpxIn0.oUGPwQ4zi0LQo9z3qayhEg'

  mapDefaults: {
    style: 'mapbox://styles/criticaljuncture/ciq1hi7yy004dcbm8kd75bkpm',
    center: [-122.2711, 37.8044],
    zoom: 13
  }

  constructor: (@mapEl, options)->
    mapboxgl.accessToken = @accessToken
    @mapSettings = _.extend(@mapDefaults, options || {})

    @createMap()

    cppMap = this
    @map.on 'load', ->
      CPP.CommunityProgramMarkers.add(cppMap.map)

  createMap: ->
    cppMap = this
    @map = new mapboxgl.Map(
      _.extend(@mapSettings, {container: cppMap.mapEl.get(0)})
    )
