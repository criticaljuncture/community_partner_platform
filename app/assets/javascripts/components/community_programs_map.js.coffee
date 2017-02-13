#= require components/community_programs_map/community_program_markers

class @CPP.CommunityProgramsMap
  accessToken: 'pk.eyJ1IjoiY3JpdGljYWxqdW5jdHVyZSIsImEiOiJjaXExZjdkdWUwMHg0Zndub255c3I0OGpxIn0.oUGPwQ4zi0LQo9z3qayhEg'

  mapDefaults: {
    center: [-122.2711, 37.8044], #Oakland City Center
    debug: false,
    style: 'mapbox://styles/criticaljuncture/ciq1hi7yy004dcbm8kd75bkpm',
    zoom: 13,
  }

  constructor: (@mapEl, options)->
    mapboxgl.accessToken = @accessToken
    @mapSettings = _.extend(@mapDefaults, options || {})

    @createMap()
    @addMapControls()

    cppMap = this
    @map.on 'load', ->
      CPP.CommunityProgramMarkers.add(cppMap.map, "Elementary")
      CPP.CommunityProgramMarkers.add(cppMap.map, "Middle")
      CPP.CommunityProgramMarkers.add(cppMap.map, "Senior")

    if @mapSettings.debug
      @logEvents()

  createMap: ->
    cppMap = this
    @map = new mapboxgl.Map(
      _.extend(@mapSettings, {container: cppMap.mapEl.get(0)})
    )

  addMapControls: ->
    @map.addControl(
      new mapboxgl.NavigationControl(),
      'bottom-right'
    )

  logEvents: ->
    map = @map

    @map.on 'zoom', ->
      console.info 'Zoom: ', map.getZoom()

    @map.on 'move', ->
      console.info 'Bearing: ', map.getBearing()
      console.info 'Center: ', map.getCenter()
      console.info 'Bounds: ', map.getBounds()
