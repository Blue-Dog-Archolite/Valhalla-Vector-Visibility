angular.module('valhalla').controller 'MessagesController', \
['$rootScope', '$scope', '$timeout', 'sharedMessagesService', \
($rootScope, $scope, $timeout, sharedMessagesService) ->
  $scope.alerts = []

  $close_alert = (index) ->
    alert_message = $scope.alerts.splice index, 1
    set_queue_size()


  add_alert = (alert_message, timeout) ->
    set_queue_size()
    $scope.previous = $timeout(close_previous, 1000) unless alert_message.type == 'error'
    $scope.alerts.push
      type: alert_message.type
      msg: alert_message.body
    set_queue_size()
    timeout = 60000 if alert_message.type == 'info'
    $scope.new = $timeout(close_new, timeout || 6000)

  close_previous = () ->
    $close_alert(0) if $scope.alerts.length > 1

  close_new = () ->
    $close_alert(0) if $scope.alerts.length > 0

  close_all_alerts = () ->
    index = 0
    for alert in $scope.alerts
      if  alert && alert.type == 'success'
        $close_alert(index)
      else
        index += 1

  $scope.$on "add_alert", (event, message) ->
    add_alert(message)

  $scope.$on "clear_alerts", (event, message) ->
    $timeout.cancel($scope.previous)
    $timeout.cancel($scope.new)
    $timeout(close_all_alerts, 2000)

  info_count = () ->
    ($scope.alerts.filter (alert) ->
      alert.type == "info").length

  success_count = () ->
    ($scope.alerts.filter (alert) ->
      alert.type == "success").length

  error_count = () ->
    ($scope.alerts.filter (alert) ->
      alert.type == "error").length

  set_queue_size = () ->
    sharedMessagesService.set_queue_size(success_count() + error_count())
]
