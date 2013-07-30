Airbrake.configure do |config|
  config.api_key = '3385c88e54500c9e36eef2c0bbb1a103'
  config.host    = 'monitor.siclic.fr'
  config.port    = 3000
  #config.secure  = config.port == 443
  config.development_environments = []
end
