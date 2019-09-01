begin
  $redis = Redis.new(host: 'localhost')
  $redis.ping
rescue Errno::ECONNREFUSED => e
  puts 'Error: Redis server unavailable. Shutting down...'
  exit 1
end
