require 'geo_names'

GeoNames.configure do |config|
  config.username = ENV.fetch('GEONAMES_USERNAME')
end
