json.array! @flight_plans do |flight_plan|
  json.id flight_plan.id
  json.origin flight_plan.origin
  json.destination flight_plan.destination
  json.speed flight_plan.speed
  json.interval flight_plan.interval
  json.departure_time flight_plan.departure_time
end
