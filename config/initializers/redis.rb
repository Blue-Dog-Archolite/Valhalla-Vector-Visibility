require 'redis'

REDIS = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_POST'])
