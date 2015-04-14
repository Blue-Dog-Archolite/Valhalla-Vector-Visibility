angular.module('valhalla').service 'sharedMessagesService', \
[ '$rootScope', ($rootScope) ->

  queue_size = 0

  send_alert = (msg, type) ->
    type = "success" unless type
    $rootScope.$broadcast "add_alert", {body: msg, type: type}

  send_error = (error) ->
    if typeof error is "string"
      send_alert(error, 'error')
    else
      for field, error_messages of error
        for error_message in error_messages
          send_alert("#{field} #{error_message}", 'error')

  send_event = (event, data) ->
    $rootScope.$broadcast event, data

  is_message_queue_empty = () ->
    queue_size == 0

  set_queue_size = (size) ->
    queue_size = size

  get_queue_size = (size) ->
    queue_size

  {
    send_alert
    send_error
    send_event
    is_message_queue_empty
    set_queue_size
    get_queue_size
  }

]
