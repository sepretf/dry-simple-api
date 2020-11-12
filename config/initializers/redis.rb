# frozen_string_literal: true

if Rails.env.production? || Rails.env.quality?
  r_config  = YAML.load_file('config/redis.yml')
  url       = "redis://#{r_config['REDIS']['master_name']}:#{r_config['REDIS']['port']}/#{r_config['REDIS']['app']}"
  sentinels = r_config['REDIS']['sentinels'].map { |conf| { host: conf[1]['host'], port: conf[1]['port'] } }
  Redis.current = Redis.new(
                    url:                url,
                    password:           r_config['REDIS']['password'],
                    sentinels:          sentinels,
                    role:               r_config['REDIS']['role'],
                    reconnect_timeout:  30,
                    reconnect_attempts: 10
                  )
else
  uri = URI.parse(ENV['REDIS'] || 'redis://localhost:6379')
  Redis.current = Redis.new(url: uri)
end
