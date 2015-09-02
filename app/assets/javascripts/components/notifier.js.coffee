class @CJ.Notifier
  @notificationWrapper: ()->
    $(".flash-messages .alerts")

  @displayNotification: (message, type, options)->
    options = _.extend({clearAll: true}, options || {})

    if options.clearAll
      @clearNotfications()

    notification = HandlebarsTemplates['alerts']({
      "alert-class": @notificationClass(type)
      "message": message
    })

    @notificationWrapper().append notification

  @clearNotfications: ()->
    @notificationWrapper().empty()

  @notificationClass: (type)->
    switch type
      when 'error'   then 'danger'
      when 'success' then 'success'
      when 'warning' then 'warning'
