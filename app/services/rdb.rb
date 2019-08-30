class Rdb
  class << self
    def exists?(key:)
      redis.exists(key)
    end

    def hash_get(key:, field:)
      redis.hget(key, field)
    end

    def hash_set(key:, field:, value:)
      redis.hset(key, field, value)
    end

    private

    def redis
      $redis
    end
  end
end
